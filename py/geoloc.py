import sys
from geopy.geocoders import Nominatim

lugar = sys.argv[1]
geolocator = Nominatim(user_agent='email')
location = geolocator.geocode(lugar,timeout=10000)
#print(location.address)

jsonCoords='{'

if location == None:
    #print('Nada')
    jsonCoords+='"coords":{'
    jsonCoords+='"lat": -1,'
    jsonCoords+='"lon": -1'
    jsonCoords+='}'
else:
    jsonCoords+='"coords":{'
    jsonCoords+='"lat": '+str(location.latitude)+','
    jsonCoords+='"lon": '+str(location.longitude)
    jsonCoords+='}'


jsonCoords+='}'
print(jsonCoords)
