import swisseph as swe
import datetime

# Configura la ruta de las efemérides (asegúrate de tener los archivos necesarios)
swe.set_ephe_path('ruta/a/las/efemérides')

# Define el número de cuerpo celestial para Neptuno
NEPTUNO = swe.NEPTUNE

# Define la fecha y hora para la consulta (en formato UTC)
# Aquí estoy usando un ejemplo para el 1 de enero de 2024 a las 12:00:00 UTC
fecha_utc = datetime.datetime(2024, 1, 1, 12, 0, 0)

# Convierte la fecha y hora UTC a un día juliano
dia_juliano = swe.julday(fecha_utc.year, fecha_utc.month, fecha_utc.day, fecha_utc.hour + fecha_utc.minute / 60 + fecha_utc.second / 3600)

# Calcula la posición de Neptuno en el día juliano especificado
posicion_neptuno, _ = swe.calc_ut(dia_juliano, NEPTUNO)

# Imprime la posición de Neptuno (en grados)
print("Posición de Neptuno:", posicion_neptuno)

explanation = """
Los datos devueltos representan la posición de Neptuno en el espacio en un momento específico en términos de coordenadas astronómicas. Aquí está el significado de cada valor devuelto:

1. Longitud eclíptica (en grados): Este valor representa la longitud de Neptuno a lo largo de la eclíptica, que es la proyección de la órbita de Neptuno en el plano del sistema solar, medida en grados. En este caso, el valor es aproximadamente 355.08 grados.

2. Latitud eclíptica (en grados): Este valor representa la latitud de Neptuno con respecto al plano de la eclíptica, medida en grados. Un valor positivo indica que Neptuno está por encima del plano de la eclíptica, mientras que un valor negativo indica que está por debajo. En este caso, el valor es aproximadamente -1.24 grados.

3. Distancia desde el Sol (en unidades astronómicas): Este valor representa la distancia promedio entre Neptuno y el Sol, medida en unidades astronómicas (UA), donde 1 UA es la distancia promedio entre la Tierra y el Sol (aproximadamente 149.6 millones de kilómetros). En este caso, el valor es aproximadamente 30.15 UA.

4. Velocidad en longitud (en grados por día): Este valor representa la velocidad angular de Neptuno en su órbita alrededor del Sol, medida en grados por día. En este caso, el valor es aproximadamente 0.0148 grados por día.

5. Velocidad en latitud (en grados por día): Este valor representa la velocidad angular de cambio en la latitud de Neptuno, medida en grados por día. En este caso, el valor es aproximadamente 0.00055 grados por día.

6. Velocidad en distancia (en UA por día): Este valor representa la velocidad de cambio en la distancia entre Neptuno y el Sol, medida en unidades astronómicas por día. En este caso, el valor es aproximadamente 0.0167 UA por día.

Estos valores proporcionan información detallada sobre la posición y el movimiento de Neptuno en el momento específico que has consultado.
"""

print(explanation)

version_probada="Versión de pyswisseph probado en Ubutnu 20.04 en la última edición de este archivo importante.py el día 22/02/2024. Version=20220908"
print(version_probada)
version = swe.__version__
print("Version actual:", version)
