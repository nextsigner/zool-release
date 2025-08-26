# -*- coding: utf-8 -*-
"""
Este script busca la fecha y hora exactas en las que el Sol alcanza una longitud de arco específica
utilizando un método iterativo, ya que la función revrs() no está disponible en versiones recientes
de PySwissEph.
"""
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

import json
import datetime as dt

def get_sun_lon_at_time(jd_ut, lon, lat, alt):
    """
    Calcula la longitud del Sol en un día juliano y posición de observador dados.
    """
    swe.set_topo(lon, lat, alt)
    jul_day = jd_ut

    # Se añade la flag swe.FLG_SWIEPH para utilizar los datos de efemérides Swiss Ephemeris
    # y swe.FLG_MOSEPH para los datos de efemérides de la Luna del JPL DE431
    # Se calcula la posición del sol
    # Es importante utilizar la constante =0 para indicar el objeto a buscar
    result = swe.calc_ut(jul_day, 0)
    return result[0][0]

def getRs2_iterative(lon, lat, alt, gmt_offset, target_lon_deg, target_lon_min, target_lon_sec, year, ephe_path):
    """
    Calcula la fecha y hora en que el Sol alcanza una longitud de arco específica
    mediante un método iterativo.
    """
    swe.set_ephe_path(ephe_path)

    # Convierte la longitud objetivo a grados decimales
    target_lon = target_lon_deg + target_lon_min / 60.0 + target_lon_sec / 3600.0

    # Establece la posición del observador
    swe.set_sid_mode(swe.SIDM_LAHIRI)

    # Crea el tiempo de inicio y fin para la búsqueda
    start_time = dt.datetime(year, 1, 1, 0, 0, 0, tzinfo=dt.timezone.utc)
    end_time = dt.datetime(year + 1, 1, 1, 0, 0, 0, tzinfo=dt.timezone.utc)

    # Usamos jdutil para convertir datetime a Julian Day
    start_jd = jdutil.datetime_to_jd(start_time)
    end_jd = jdutil.datetime_to_jd(end_time)

    # Búsqueda por bisección
    jd_ut_found = None
    tolerance = 1 / (24 * 60 * 60) # Tolerancia de 1 segundo

    while (end_jd - start_jd) > tolerance:
        mid_jd = (start_jd + end_jd) / 2
        mid_lon = get_sun_lon_at_time(mid_jd, lon, lat, alt)

        # Ajusta el rango de búsqueda
        if mid_lon < target_lon:
            start_jd = mid_jd
        else:
            end_jd = mid_jd

    jd_ut_found = start_jd

    if jd_ut_found:
        # Usa jdutil para convertir el día juliano a datetime
        date_ut = jdutil.jd_to_datetime(jd_ut_found)

        # Ajusta a la zona horaria del observador
        gmt_timedelta = dt.timedelta(hours=gmt_offset)
        date_local = date_ut + gmt_timedelta

        # Crea el JSON de salida
        result = {
            "a": date_local.year,
            "m": date_local.month,
            "d": date_local.day,
            "h": date_local.hour,
            "min": date_local.minute
        }
        return result
    else:
        return {"error": "No se encontró el evento para el año y la longitud especificados."}

if __name__ == '__main__':
    # Valida el número de argumentos
    if len(sys.argv) != 10:
        print("Uso: python3 getRs2.py <grado_sol> <minuto_sol> <segundo_sol> <año> <gmt> <latitud> <longitud> <altura> <ruta_ephe>")
        sys.exit(1)

    # Extrae los argumentos de la línea de comandos
    try:
        sol_grado = int(sys.argv[1])
        sol_minuto = int(sys.argv[2])
        sol_segundo = int(sys.argv[3])
        anio = int(sys.argv[4])
        gmt = float(sys.argv[5])
        latitud = float(sys.argv[6])
        longitud = float(sys.argv[7])
        altura = float(sys.argv[8])
        ephe_ruta = sys.argv[9]
    except (ValueError, IndexError) as e:
        print(f"Error en los argumentos: {e}")
        sys.exit(1)

    # Llama a la función principal y imprime el JSON
    resultado = getRs2_iterative(longitud, latitud, altura, gmt, sol_grado, sol_minuto, sol_segundo, anio, ephe_ruta)
    print(json.dumps(resultado, indent=4))
