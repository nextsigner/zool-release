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

# Verifica que se hayan proporcionado los argumentos adecuados
if len(sys.argv) < 4:
    print("Error: Debes proporcionar la fecha de inicio y la fecha de fin en el formato dd_mm_yyyy, y la ruta a las efemérides.")
    sys.exit(1)

# Función para convertir la fecha de formato de cadena a objeto datetime
def parse_fecha(fecha_str):
    try:
        return datetime.datetime.strptime(fecha_str, '%d_%m_%Y')
    except ValueError:
        print("Error: La fecha debe estar en el formato dd_mm_yyyy.")
        sys.exit(1)

# Parsea las fechas de los argumentos de la línea de comandos
fecha_inicio = parse_fecha(sys.argv[1])
fecha_fin = parse_fecha(sys.argv[2])

# Define la ruta a las efemérides
ruta_efemerides = sys.argv[3]

# Configura la ruta de las efemérides
#swe.set_ephe_path(ruta_efemerides)
swe.set_ephe_path('../swe/')
# Itera sobre el rango de fechas
fecha = fecha_inicio
while fecha <= fecha_fin:
    # Calcula el momento del eclipse solar global más cercano a la fecha actual
    momento_eclipse, tipo_eclipse = swe.sol_eclipse_when_glob(fecha.year, fecha.month, fecha.day)

    # Si se encontró un eclipse, imprime la información
    if momento_eclipse:
        print("Fecha del eclipse:", fecha)
        print("Tipo de eclipse:", tipo_eclipse)

    # Avanza al siguiente día
    fecha += datetime.timedelta(days=1)
