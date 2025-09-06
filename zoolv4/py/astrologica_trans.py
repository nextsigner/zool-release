from decimal import Decimal
import sys, os, pathlib, json
import subprocess
from subprocess import run, PIPE

#Este archivo devuelve un archivo json con un listado con todos los aspectos entre un cuerpo y otro en un determinado año.
#Ejemplo
#python3 ./astrologica_trans.py 20 6 1975 23 04 -3 -35.47857 -69.61535 Pluto Moon Squ 1985 '/home/ns/Descargas/ast73src/astrolog'

#C:\\Users\\qt\\Downloads\\ast72win64\\astrolog -qa 6 20 1985 23 04 3W 69W36 35S28 -dy

#E:\zool\Python>python ../py/astrologica_trans.py 20 6 1975 23 04 -3 -35.47857 -69.61535 Pluto Moon Squ 1985 "C:\Users\qt\Downloads\ast72win64\astrolog"


#python3 <este archivo> <dia> <mes> <año> <hora> <minuto> <gmt> <lat> <lon> <cuerpo 1> <cuerpo 2> <aspecto> <año de aspectos> <ubicación de astrolog>

def decdeg2dms(dd):
   is_positive = dd >= 0
   dd = abs(dd)
   minutes,seconds = divmod(dd*3600,60)
   degrees,minutes = divmod(minutes,60)
   degrees = degrees if is_positive else -degrees
   return (degrees,minutes,seconds)

#Calculo para Fortuna Diurna Asc + Luna - Sol
#Calculo para Fortuna Nocturna Asc + Sol - Luna


dia = sys.argv[1]
mes = int(sys.argv[2]) #+ 1
anio = sys.argv[3]
hora = sys.argv[4]
min = sys.argv[5]
gmt = sys.argv[6]

lat = sys.argv[7]
lon = sys.argv[8]

planetSearch1=sys.argv[9]
planetSearch2=sys.argv[10]
aspSearch=sys.argv[11]
anioF=sys.argv[12]

astrologPath=sys.argv[13]



if float(gmt) < 0.0:
    gmtCar='W'
    gmtNum=abs(float(gmt))
else:
    gmtCar='E'
    gmtNum=float(gmt)

if float(lon) < 0:
    lonCar='W'
else:
    lonCar='E'


if float(lat) < 0:
    latCar='S'
else:
    latCar='N'


GMSLat=decdeg2dms(float(lat))
GMSLon=decdeg2dms(float(lon))

#print('Fecha: '+dia+'/'+mes+'/'+anio+' Hora: '+hora+':'+min)

#Astrolog
#Consulta normal ./astrolog -qa 6 20 1975 23:00 3W 69W57 35S47
#Consultar Aspectos ./astrolog -qa 6 20 1975 23:00 3W 69W57 35S47 -a -A 4

json= {}
cant=0


#Con=Conjunción
#Squ=Cuadratura
#Tri=Trígono
#Sex=Sextil
#Opp=Oposición


dev=False


log=''
#cmd=astrologPath + ' -qa ' + str(int(mes)) + ' ' + str(int(dia)) + ' ' + str(anioF) + ' ' + str(hora) + ' ' + str(min) + ' ' + str(gmtNum) + ''+ gmtCar + ' ' + str(abs(int(GMSLon[0]))) + '' + lonCar + '' +str(int(GMSLon[1])) + ' ' + str(abs(int(GMSLat[0]))) + '' + latCar + '' +str(int(GMSLat[1])) + ' -dy'
cmd=astrologPath + ' -qa ' + str(int(mes)) + ' ' + str(int(dia)) + ' ' + str(anioF) + ' ' + str(hora) + ':' + str(min) + ' ' + str(gmtNum) + ''+ gmtCar + ' ' + str(abs(int(GMSLon[0]))) + '' + lonCar + '' +str(int(GMSLon[1])) + ' ' + str(abs(int(GMSLat[0]))) + '' + latCar + '' +str(int(GMSLat[1])) + ' -dy'
if dev:
    print(cmd)
cmd1=[astrologPath, '-qa', str(int(mes)), str(int(dia)), str(anioF), hora+ ':' + min, str(gmtNum) + ''+ gmtCar, str(abs(int(GMSLon[0]))) + '' + lonCar + '' +str(int(GMSLon[1])), str(abs(int(GMSLat[0]))) + '' + latCar + '' +str(int(GMSLat[1])), '-dy']
#print(cmd1)
proc = subprocess.Popen(args=cmd1, stdout=subprocess.PIPE)
output = proc.stdout.read()
#print (output)
indexLista=0
lista = str(output.decode("utf-8")).split('\n')
#print(lista)
for l in lista:
    ioAsp = l.find(aspSearch)
    arrayLin=l.split(aspSearch)

    if len(arrayLin) > 1:
        ioPlanet1 = str(arrayLin[0]).find(planetSearch1)
        ioPlanet1B = str(arrayLin[1]).find(planetSearch1)
        ioPlanet2 = str(arrayLin[1]).find(planetSearch2)
        ioPlanet2B = str(arrayLin[0]).find(planetSearch2)
    else:
        continue
    if ioAsp > 0 and (ioPlanet1 > 0 or ioPlanet1B > 0 ) and (ioPlanet2 > 0 or ioPlanet2B > 0 ) and len(arrayLin) > 1:
        #log += str(arrayLin)
        cant = cant + 1
        if dev == True:
            print('io:'+str(ioAsp))
            print('iop1:'+str(ioPlanet1))
            print('iop2:'+str(ioPlanet2))
            print('\n')
        dC = l.replace('  ', ' ')
        dC = dC.replace('   ', ' ')
        dC = dC.replace('/ ', '/')
        ad=dC.split(' ')
        diaR=1
        mesR=1
        anioR=1900
        hora='00'
        minutos='00'
        for dato in ad:
            ioDia=dato.find('/')
            ioHoraAm=dato.find('am')
            ioHoraPm=dato.find('pm')
            #ioAsp=dC.find(str(' '+aspSearch))
            #print('ioAsp: '+str(ioAsp))
            #print('dC: '+dC)
            #print('aspSearch: '+aspSearch)
            #if ioAsp >= 0:
            if ioDia > 0:
                    m00=dato.split('/')
                    diaR=m00[1]
                    mesR=m00[0]
                    anioR=m00[2]
            if ioHoraAm > 0 or ioHoraPm > 0:
                    m0=dato.split(':')
                    s0=int(m0[0])
                    hora = str(s0)
                    s1=m0[1]
                    if ioHoraPm > 0:
                        s0=s0+12
                        if int(s0) == 24:
                            s0=0
                        hora = str(s0)
                    minutos=str(s1).replace('am', '').replace('pm', '')
        json['item'+str(indexLista)]= {'asp': aspSearch, 'd': diaR, 'm': mesR, 'h':hora, 'min': minutos}
        indexLista = indexLista + 1



json['params']= {'cant': cant, 'c1': planetSearch1, 'c2': planetSearch2, 'a': anioF, 'aspSearch': aspSearch, 'cmdLine': cmd, 'cmdParams': cmd1, 'log':log}
if dev == True:
    print('Cant: '+str(cant))
else:
    print(str(json).replace('\'', '\"'))
