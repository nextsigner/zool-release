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

import sys
import json

def convertir_julian_day(jd):
    """Convierte un día juliano a formato gregoriano (día, mes, año, hora, minuto)."""
    year, month, day, hour = swe.revjul(jd)  # Convertir jd a año, mes, día y hora (en decimal)

    # Extraer la hora y los minutos a partir de la parte decimal de la hora
    hora = int(hour)
    minuto = int((hour - hora) * 60)

    return int(day), int(month), int(year), hora, minuto

def calcular_evento_lunar(jd):
    """Calcula si hay un evento lunar en un día juliano específico."""
    # Obtener la posición del Sol y la Luna
    lon_sol, _ = swe.calc_ut(jd, swe.SUN)  # Solo tomamos la longitud del Sol
    lon_luna, _ = swe.calc_ut(jd, swe.MOON)  # Solo tomamos la longitud de la Luna
    # Convertir las longitudes a grados y minutos
    grado_sol = int(lon_sol[0])
    minuto_sol = int((lon_sol[0] - grado_sol) * 60)

    grado_luna = int(lon_luna[0])
    minuto_luna = int((lon_luna[0] - grado_luna) * 60)

    # Comparar las posiciones
    diferencia = abs(lon_sol[0] - lon_luna[0])
    diferencia=round(diferencia, 1)
    #print(str(diferencia))
    #print(str(round(diferencia, 1)))

    # Detectar eventos
    if diferencia == 0.0:  # Aproximadamente en conjunción (luna nueva)
        return 0
    elif diferencia == 90.0:  # Cuarto creciente
        return 1
    elif diferencia == 180.0:  # Luna Llena
        return 2
    elif diferencia == 270.0:  # Cuarto menguante
        return 3
    else:
        return -1

def iterar_julian_day(jd):
    hayEvento=False
    """Iterar sobre un día juliano, avanzando cada 15 minutos durante 24 horas."""
    #incremento = 0.01041667  # Incremento de 15 minutos en días julianos (1/97 de un día)
    #incremento = 0.01041667*0.5  # Incremento de 7.5 minutos en días julianos (1/97*2 de un día)
    incremento = 0.01041667*0.25  # Incremento de 7.5 minutos en días julianos (1/97*4 de un día)

    # Iteramos durante 24 horas en intervalos de 15 minutos (97 pasos para incluir 00:00 del día siguiente)
    for i in range(97*4):
        jd_actual = jd + i * incremento
        dia, mes, anio, hora, minuto = convertir_julian_day(jd_actual)

        # Calcular evento lunar
        evento = calcular_evento_lunar(jd_actual)

        if evento >=0:
            resultado ={
                'isEvent': evento,
                'd':f"{dia}",
                'm':f"{mes}",
                'a':f"{anio}",
                'h':f"{hora}",
                'min':f"{minuto}"
            }
            #print(json.dumps(resultado, indent=4))
            hayEvento=True
            break
        #else:
            #print(f"Fecha: {dia}-{mes}-{anio}, Hora: {hora}:{minuto:02d} - No hay evento lunar.")
    if(hayEvento==False):
        resultado ={
            'isEvent': -1
        }
    return resultado
    #print(json.dumps(resultado, indent=4))

def iterar_dias_del_mes(mes, anio):
        """Itera todos los días válidos del mes y año especificados."""
        # Definir la cantidad de días en cada mes
        dias_en_mes = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

        resultados={
            'ciclos':[]
        }

        # Verificar si el año es bisiesto y ajustar febrero
        if (anio % 4 == 0 and anio % 100 != 0) or (anio % 400 == 0):
            dias_en_mes[1] = 29  # Febrero tiene 29 días en un año bisiesto

        # Validar el mes
        if mes < 1 or mes > 12:
            print("Mes inválido. Debe estar entre 1 y 12.")
            return

        # Iterar a través de los días del mes
        for dia in range(1, dias_en_mes[mes - 1] + 1):
            jd_inicial = swe.julday(anio, mes, dia, 0.0)
            #print(json.dumps(iterar_julian_day(jd_inicial), indent=4))
            resultados['ciclos'].append(iterar_julian_day(jd_inicial))
            #print(f"{dia}-{mes}-{anio}")
        return resultados

def iterar_meses(anio):
    resultados = {
        'meses': []
    }
    for mes in range(1, 12+1):
        #print(str(mes))
        resultados['meses'].append(iterar_dias_del_mes(mes, anio))

    return resultados

# Ejemplo de uso
if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Error: Debes proporcionar una fecha en el formato día-mes-año.")
        sys.exit(1)

    # Calcular el día juliano correspondiente a la fecha proporcionada
    #jd_inicial = swe.julday(anio, mes, dia, 0.0)

    # Iterar el día juliano cada 15 minutos
    #iterar_julian_day(jd_inicial)
    #print(json.dumps(iterar_julian_day(jd_inicial), indent=4))
    #iterar_dias_del_mes(10, 2024)
    #print(json.dumps(iterar_dias_del_mes(mes, anio), indent=4))
    #iterar_meses(anio)
    print(json.dumps(iterar_meses(int(sys.argv[1])), indent=4))
