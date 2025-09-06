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

import datetime
import jdutil

"""
Args:
4 # Bodie index.
186.5 # Grado float buscado.
2025 # Año de inicio de búsqueda.
1 # Mes de inicio de búsqueda.
1 # Día de inicio de búsqueda.
2025 # Año de final de búsqueda.
12 # Mes de final de búsqueda.
31 # Día de final de búsqueda.
0.5 # Velocidad de avance de día o fecha en rastreo. 0.5 avanza de a medio día.
0.5 # Tolerancia de coincidencia en la comparación del grado buscado.
"""

import json

transits = {}
transits['fechas']=[]
transits['ctxs']=[]

def dia_decimal_a_hms(dia_decimal):
    """Convierte un día decimal a horas, minutos y segundos."""

    dia = int(dia_decimal)  # Parte entera: el día
    fraccion_dia = dia_decimal - dia  # Parte decimal: la fracción del día

    segundos_totales = fraccion_dia * 24 * 60 * 60  # Segundos totales en la fracción del día

    horas = int(segundos_totales // 3600)  # Obtener las horas
    segundos_totales %= 3600 # Obtener el resto de segundos para calcular minutos y segundos
    minutos = int(segundos_totales // 60)   # Obtener los minutos
    segundos = segundos_totales % 60       # Obtener los segundos

    return dia, horas, minutos, segundos

def decimal_a_dms(decimal):
    grados = int(decimal)  # Parte entera son los grados
    minutos_decimal = (decimal - grados) * 60  # Parte decimal multiplicada por 60 para obtener minutos decimales
    minutos = int(minutos_decimal)  # Parte entera de los minutos decimales son los minutos
    segundos = (minutos_decimal - minutos) * 60  # Parte decimal de los minutos multiplicada por 60 para obtener segundos

    return grados, minutos, segundos

def transits_in_range(body, degree, start_date, end_date):
    jd = swe.julday(start_date.year, start_date.month, start_date.day, 0)
    jd_end = swe.julday(end_date.year, end_date.month, end_date.day, 0)
    while jd <= jd_end:
        flag = swe.FLG_SWIEPH
        res, serr = swe.calc_ut(jd, body, flag)
        long, lat, dist, *unused_values = res
        aDMS0=decimal_a_dms(float(degree))
        aDMS=decimal_a_dms(long)
        #if ( degree - float(sys.argv[10]) <= long <= degree + float(sys.argv[10]) ) and ( int(aDMS[1]) == 0):
        if ( int(aDMS[0]) == int(degree)) and ( int(aDMS[1]) >= int(aDMS0[1])):
            break

        if ( int(aDMS[0]) == degree) and ( int(aDMS[1]) ==  int(aDMS0[1])):
            date=jdutil.jd_to_date(jd)
            aDate=[]
            aDate.append(int(date[0]))
            aDate.append(int(date[1]))
            aDate.append(int(date[2]))
            aHora=dia_decimal_a_hms(float(date[2]))
            aDate.append(int(aHora[0]))
            aDate.append(int(aHora[1]))
            aDate.append(int(aHora[2]))
            transits['fechas'].append(aDate)
            ctx={}
            ctx['g1']=int(aDMS[0])
            ctx['m1']=int(aDMS[1])
            ctx['s1']=int(aDMS[2])
            ctx['g2']=int(aDMS0[0])
            ctx['m2']=int(aDMS0[1])
            ctx['s2']=int(aDMS0[2])
            transits['ctxs'].append(ctx)

        jd += float(sys.argv[9])  # Avanzamos medio día
    ret={}
    if(len(transits['fechas'])>0):
        ret=transits
    else:
        jd -= 30.0
        ret=transits_in_range2(body, degree, jd, end_date)

    return ret

def transits_in_range2(body, degree, jd, end_date):
    jd_end = swe.julday(end_date.year, end_date.month, end_date.day, 0)
    while jd <= jd_end:
        flag = swe.FLG_SWIEPH
        res, serr = swe.calc_ut(jd, body, flag)
        long, lat, dist, *unused_values = res
        aDMS0=decimal_a_dms(float(degree))
        aDMS=decimal_a_dms(long)
        #print("1--->"+str(aDMS[0]))
        #if ( degree - float(sys.argv[10]) <= long <= degree + float(sys.argv[10]) ) and ( int(aDMS[1]) == 0):
        if ( int(aDMS[0]) == int(degree)) and ( int(aDMS[1]) == int(aDMS0[1])):
            date=jdutil.jd_to_date(jd)
            aDate=[]
            aDate.append(int(date[0]))
            aDate.append(int(date[1]))
            aDate.append(int(date[2]))
            aHora=dia_decimal_a_hms(float(date[2]))
            aDate.append(int(aHora[0]))
            aDate.append(int(aHora[1]))
            aDate.append(int(aHora[2]))
            transits['fechas'].append(aDate)
            ctx={}
            ctx['g1']=int(aDMS[0])
            ctx['m1']=int(aDMS[1])
            ctx['s1']=int(aDMS[2])
            ctx['g2']=int(aDMS0[0])
            ctx['m2']=int(aDMS0[1])
            ctx['s2']=int(aDMS0[2])
            transits['ctxs'].append(ctx)
            break

        jd += 0.01  # Avanzamos medio día

    return transits

# Ejemplo de uso:
body = int(sys.argv[1])
#print(str(body))
degree = float(sys.argv[2])  # Grado en donde lo busco.
#print(str(degree))

anioInicio=int(sys.argv[3])
#print(str(anioInicio))
mesInicio=int(sys.argv[4])
#print(str(mesInicio))
diaInicio=int(sys.argv[5])
#print(str(diaInicio))

anioFinal=int(sys.argv[6])
#print(str(anioFinal))
mesFinal=int(sys.argv[7])
#print(str(mesFinal))
diaFinal=int(sys.argv[8])
#print(str(diaFinal))

start_date = datetime.date(anioInicio, mesInicio, diaInicio)
end_date = datetime.date(anioFinal, mesFinal, diaFinal)

result = transits_in_range(body, degree, start_date, end_date)
print(json.dumps(result))
