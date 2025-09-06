import sys
import swisseph as swe
import datetime
import json
import jdutil

#Parámetros
swePath=sys.argv[1]
planeta_num=int(sys.argv[2])
longitud_objetivo = float(sys.argv[3])
ai = int(sys.argv[4])
mi = int(sys.argv[5])
di = int(sys.argv[6])
af = int(sys.argv[7])
mf = int(sys.argv[8])
df = int(sys.argv[9])
tol = float(sys.argv[10]) #Toleracia de tiempo de rastreo

aBodies=[('Sol', 0), ('Luna', 1), ('Mercurio', 2), ('Venus', 3), ('Marte', 4), ('Júpiter', 5), ('Saturno', 6), ('Urano', 7), ('Neptuno', 8), ('Plutón', 9), ('Nodo Norte', 11), ('Nodo Sur', 10), ('Quirón', 15), ('Selena', 57), ('Lilith', 12), ('Pholus', 16), ('Ceres', 17), ('Pallas', 18), ('Juno', 19), ('Vesta', 20)]

swe.set_ephe_path(swePath)

def getJson(fecha_hora, g1, g2, aspIndex):
    datos = {
        "a": fecha_hora.year,
        "m": fecha_hora.month,
        "d": fecha_hora.day,
        "h": fecha_hora.hour,
        "min": fecha_hora.minute,
        "isData": True,
        "ai": ai,
        "mi": mi,
        "di": di,
        "af": af,
        "mf": mf,
        "df": df,
        "tol": tol,
        "b": aBodies[planeta_num][0],
        "numAstro": planeta_num,
        "gb": g1, #Grado Buscado
        "gr": g2, #Grado Retornado
        "aspIndex": aspIndex
    }
    return json.dumps(datos)

def esta_en_rango(valor_actual, valor_objetivo, tolerancia):
    """
    Verifica si valor_actual está dentro del rango de valor_objetivo +/- tolerancia.
    Considera la circularidad de los grados (0-360).
    """
    rango_inferior = (valor_objetivo - tolerancia + 360) % 360
    rango_superior = (valor_objetivo + tolerancia) % 360

    if rango_inferior <= rango_superior:
        return rango_inferior <= valor_actual <= rango_superior
    else: # El rango cruza el punto 0/360
        return valor_actual >= rango_inferior or valor_actual <= rango_superior

def encontrar_fecha_longitud(longitud_deseada):
    # -1 = no hay aspectos. 0 = oposición. 1 = cuadratura. 2 = trígono. 3 = conjunción. 4 = sextil. 5 = semicuadratura. 6 = quincuncio
    aspIndex=-1
    jd_inicio = swe.julday(ai, mi, di, 0.0)
    jd_fin = swe.julday(af, mf, df, 0.0)
    tjd = jd_inicio
    while tjd <= jd_fin:
        #pl_pos, _ = swe.calc_ut(tjd, planeta_num, swe.FLG_SPEED)
        pl_pos, _ = swe.calc_ut(tjd, int(aBodies[planeta_num][1]    ), swe.FLG_SPEED)
        longitud_actual = pl_pos[0]

        # Cálculos de las longitudes para los aspectos
        long_deseadaOp = (longitud_deseada + 180.00) % 360
        long_deseadaC1 = (longitud_deseada + 90.00) % 360
        long_deseadaC2 = (longitud_deseada - 90.00 + 360) % 360
        long_deseadaT1 = (longitud_deseada + 120.00) % 360
        long_deseadaT2 = (longitud_deseada - 120.00 + 360) % 360
        long_deseadaS1 = (longitud_deseada + 60.00) % 360 # Sextil +60
        long_deseadaS2 = (longitud_deseada - 60.00 + 360) % 360 # Sextil -60
        long_deseadaSC1 = (longitud_deseada + 45.00) % 360 # Semicuadratura +45
        long_deseadaSC2 = (longitud_deseada - 45.00 + 360) % 360 # Semicuadratura -45
        long_deseadaQ1 = (longitud_deseada + 150.00) % 360 # Quincuncio +150
        long_deseadaQ2 = (longitud_deseada - 150.00 + 360) % 360 # Quincuncio -150


        if (esta_en_rango(longitud_actual, longitud_deseada, tol) or
            esta_en_rango(longitud_actual, long_deseadaOp, tol) or
            esta_en_rango(longitud_actual, long_deseadaC1, tol) or
            esta_en_rango(longitud_actual, long_deseadaC2, tol) or
            esta_en_rango(longitud_actual, long_deseadaT1, tol) or
            esta_en_rango(longitud_actual, long_deseadaT2, tol) or
            esta_en_rango(longitud_actual, long_deseadaS1, tol) or
            esta_en_rango(longitud_actual, long_deseadaS2, tol) or
            esta_en_rango(longitud_actual, long_deseadaSC1, tol) or
            esta_en_rango(longitud_actual, long_deseadaSC2, tol) or
            esta_en_rango(longitud_actual, long_deseadaQ1, tol) or
            esta_en_rango(longitud_actual, long_deseadaQ2, tol)):

            if esta_en_rango(longitud_actual, longitud_deseada, tol):
                aspIndex=3 # Conjunción
            elif esta_en_rango(longitud_actual, long_deseadaOp, tol):
                aspIndex=0 # Oposición
            elif esta_en_rango(longitud_actual, long_deseadaC1, tol) or esta_en_rango(longitud_actual, long_deseadaC2, tol):
                aspIndex=1 # Cuadratura
            elif esta_en_rango(longitud_actual, long_deseadaT1, tol) or esta_en_rango(longitud_actual, long_deseadaT2, tol):
                aspIndex=2 # Trígono
            elif esta_en_rango(longitud_actual, long_deseadaS1, tol) or esta_en_rango(longitud_actual, long_deseadaS2, tol):
                aspIndex=4 # Sextil
            elif esta_en_rango(longitud_actual, long_deseadaSC1, tol) or esta_en_rango(longitud_actual, long_deseadaSC2, tol):
                aspIndex=5 # Semicuadratura
            elif esta_en_rango(longitud_actual, long_deseadaQ1, tol) or esta_en_rango(longitud_actual, long_deseadaQ2, tol):
                aspIndex=6 # Quincuncio

            fecha_utc = jdutil.jd_to_datetime(tjd)
            return getJson(fecha_utc, longitud_deseada, longitud_actual, aspIndex)

        # Incrementa la fecha en la tolerancia de tiempo de rastreo
        tjd += tol

    return json.dumps({"isData": False, "ai": ai, "mi": mi, "di": di, "af": af, "mf": mf, "df": df, "b": aBodies[planeta_num][0], "gb": longitud_deseada, "gr": -1.0, "tol": tol, "numAstro": planeta_num})

if __name__ == "__main__":
    fecha_encontrada = encontrar_fecha_longitud(longitud_objetivo)
    #print(aBodies[planeta_num][1])
    #exit()
    print(fecha_encontrada)
