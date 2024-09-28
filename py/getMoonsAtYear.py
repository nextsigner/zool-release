import sys
import swisseph as swe
import datetime
import json

# Constantes para el Sol y la Luna
SE_SUN = swe.SUN
SE_MOON = swe.MOON

def obtener_fases_lunares(year):
    jd_start = swe.julday(year - 1, 12, 10, 0.0)
    jd_end = swe.julday(year + 1, 1, 20, 0.0)

    ciclos = []

    jd = jd_start
    while jd < jd_end:
        sun_pos = swe.calc_ut(jd, SE_SUN)[0][0]
        moon_pos = swe.calc_ut(jd, SE_MOON)[0][0]
        fase = (moon_pos - sun_pos) % 360

        if 0 <= fase < 1 or 359 <= fase < 360:
            tipo_fase = "Luna Nueva"
        elif 89 <= fase < 91:
            tipo_fase = "Cuarto Creciente"
        elif 179 <= fase < 181:
            tipo_fase = "Luna Llena"
        elif 269 <= fase < 271:
            tipo_fase = "Cuarto Menguante"
        else:
            tipo_fase = None

        if tipo_fase:
            date = swe.revjul(jd)
            fecha_evento = datetime.datetime(date[0], date[1], date[2])

            ciclos.append({
                't': tipo_fase,
                'd': fecha_evento.day,
                'm': fecha_evento.month,
                'a': fecha_evento.year
            })

        jd += 0.1

    return ciclos

def obtener_eclipses(year):
    jd_start = swe.julday(year - 1, 12, 10, 0.0)
    jd_end = swe.julday(year + 1, 1, 20, 0.0)

    eclipses = []

    jd = jd_start
    while jd < jd_end:
        retflag, tret = swe.sol_eclipse_when_glob(jd, swe.FLG_SWIEPH)
        date = swe.revjul(tret[0])
        fecha_eclipse = datetime.datetime(date[0], date[1], date[2])

        eclipses.append({
            't': 'Eclipse Solar',
            'd': fecha_eclipse.day,
            'm': fecha_eclipse.month,
            'a': fecha_eclipse.year
        })

        retflag, tret = swe.lun_eclipse_when(jd, swe.FLG_SWIEPH)
        date = swe.revjul(tret[0])
        fecha_eclipse = datetime.datetime(date[0], date[1], date[2])

        eclipses.append({
            't': 'Eclipse Lunar',
            'd': fecha_eclipse.day,
            'm': fecha_eclipse.month,
            'a': fecha_eclipse.year,
            'h': fecha_eclipse.hour,
            'min': fecha_eclipse.minute
        })

        jd += 0.1

    return eclipses

def main():
    year = int(sys.argv[1])
    tipos = str(sys.argv[2])
    resultado = {}

    if tipos == "ciclos":
        #print("Ciclos....")
        ciclos_lunares = obtener_fases_lunares(year)
        resultado = {
            'ciclos': ciclos_lunares
        }

    if tipos == "eclipses":
        #print("Eclipses....")
        eclipses = obtener_eclipses(year)
        resultado = {
            'eclipses': eclipses
        }
    #ciclos_lunares = obtener_fases_lunares(year)
    #eclipses = obtener_eclipses(year)
    print(json.dumps(resultado, indent=4))

if __name__ == "__main__":
    main()
