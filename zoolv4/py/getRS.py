#-->Import pyswisseph portable
import os
import sys
import platform

script_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, script_dir)

system_name = platform.system()

if system_name == "Windows":
    import swisseph as swe
else:
    import pyswisseph_lin_2_10_3_2_portable.swisseph as swe

#<--Import pyswisseph portable

import jdutil

import sys
import json
from datetime import datetime, timedelta

def get_solar_return_date(day, month, year, hour, minute, gmt_offset, lat, lon, natal_sun_longitude, house_type, swe_path):
    """
    Calcula la fecha y hora de la revolución solar utilizando interpolación lineal.
    """
    swe.set_ephe_path(swe_path)
    
    # Convierte la fecha y hora de nacimiento a formato datetime
    natal_datetime = datetime(int(year), int(month), int(day), int(hour), int(minute))
    
    # Convierte la fecha y hora de nacimiento a tiempo juliano
    jd_natal =jdutil.datetime_to_jd(natal_datetime)
    #jd_natal = swe.utc_to_jd(natal_datetime.year, natal_datetime.month, natal_datetime.day,
                            #natal_datetime.hour, natal_datetime.minute, 0, float(gmt_offset))[1]
    
    # Aproximamos el tiempo de la revolución solar un año después del nacimiento.
    # Usamos 365.2425 días para un año trópico.
    jd_approx = jd_natal + 365.2425
    
    # Calculamos la longitud del Sol en ese momento aproximado
    sun_lon_approx = swe.calc_ut(jd_approx, 0)[0][0]
    
    # Definimos la longitud natal normalizada en un rango de [0, 360)
    natal_lon_norm = natal_sun_longitude % 360
    
    # El bucle busca el momento exacto de la revolución solar
    # Realizamos iteraciones para refinar el resultado
    jd_solar_return = jd_approx
    for _ in range(5):  # 5 iteraciones son suficientes para una alta precisión
        
        # Obtenemos la longitud del Sol en dos momentos cercanos
        sun_lon_prev = swe.calc_ut(jd_solar_return - 0.5, 0)[0][0]
        sun_lon_current = swe.calc_ut(jd_solar_return, 0)[0][0]

        # Normalizamos las longitudes para evitar problemas con el cambio de 360 a 0 grados
        sun_lon_prev_norm = sun_lon_prev % 360
        sun_lon_current_norm = sun_lon_current % 360
        
        # Manejamos el caso en que el sol cruza el punto 0° de Aries
        if sun_lon_prev_norm > sun_lon_current_norm:
            if natal_lon_norm < sun_lon_prev_norm:
                natal_lon_norm += 360

        # Calculamos la diferencia en longitud y tiempo
        lon_diff = sun_lon_current_norm - sun_lon_prev_norm
        time_diff = 0.5 # Diferencia de 12 horas en JD
        
        # Encontramos cuánto tiempo necesitamos para llegar a la longitud natal
        time_to_natal_lon = time_diff * ((natal_lon_norm - sun_lon_prev_norm) / lon_diff)
        
        # Ajustamos el tiempo juliano para la próxima iteración
        jd_solar_return += (time_to_natal_lon - time_diff/2)

    # Convierte el tiempo juliano final a fecha y hora UTC
    dt_solar_return_utc = swe.jdut1_to_utc(jd_solar_return)
    
    # Crea un objeto datetime UTC y lo ajusta al offset de la zona horaria local
    dt_solar_return_local = datetime(
        dt_solar_return_utc[0], dt_solar_return_utc[1], dt_solar_return_utc[2],
        dt_solar_return_utc[3], dt_solar_return_utc[4], int(dt_solar_return_utc[5])
    )
    tz_offset_seconds = float(gmt_offset) * 3600
    dt_solar_return_local += timedelta(seconds=tz_offset_seconds)
    
    # Prepara el resultado en un diccionario
    result = {
        "fecha": dt_solar_return_local.strftime("%Y-%m-%d"),
        "hora": dt_solar_return_local.strftime("%H:%M:%S")
    }
    
    return json.dumps(result, indent=4)

if __name__ == "__main__":
    # Parámetros del script
    try:
        day = sys.argv[1]
        month = sys.argv[2]
        year = sys.argv[3]
        hour = sys.argv[4]
        minute = sys.argv[5]
        gmt_offset = sys.argv[6]
        lat = sys.argv[7]
        lon = sys.argv[8]
        grado_arg = int(sys.argv[9])
        minuto_arg = int(sys.argv[10])
        segundo_arg = int(sys.argv[11])
        house_type = sys.argv[12]
        swe_path = sys.argv[13]

        # Convierte la longitud natal a un solo valor decimal
        natal_sun_longitude = grado_arg + minuto_arg / 60 + segundo_arg / 3600

        # Ejecuta la función principal y imprime el JSON resultante
        result_json = get_solar_return_date(day, month, year, hour, minute, gmt_offset, lat, lon, natal_sun_longitude, house_type, swe_path)
        print(result_json)
    except IndexError:
        print("Error: Se esperan 13 parámetros. Por favor, revisa la documentación para el uso correcto.")
        sys.exit(1)
