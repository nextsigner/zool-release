import QtQuick 2.0

Item{
    id: r
    property url server: 'http://vps-3937361-x.dattaweb.com'

    //--> Save Zooland Params
    QtObject{
        id: saveZoolParams
        function setData(data, isData){
            //if(apps.dev){
                //log.lv('saveZoolParams:\n'+JSON.stringify(JSON.parse(data), null, 2))
            log.lv('saveZoolParams isData:'+isData)
            //}
            if(isData){
                let j=JSON.parse(data)
                if(j.isRec){
                    if(apps.dev){
                        log.lv('New remote params, id: '+j.params._id)
                    }
                    //app.j.showMsgDialog('Zool Informa', 'Los datos se han guardado.', 'Una copia del archivo '+app.currentNom+' ha sido respaldado en el servidor de Zool.')
                    log.lv('Zool Informa Error!\nLos datos si han sido guardados '+j.msg)
                }else{
                    //app.j.showMsgDialog('Zool Informa Error!', 'Los datos no han sido guardados.', j.msg)
                    log.lv('Zool Informa Error!\nLos datos no han sido guardados '+j.msg)
                }

            }else{
                //app.j.showMsgDialog('Zool Informa', 'Los datos no se han guardado en el servidor.', 'No se ha copia del archivo '+app.currentNom+'. No ha sido respaldado en el servidor de Zool.\nPosiblemente usted no esté conectado a internet o el servidor de Zool no se encuentra disponible en estos momentos.')
            }
        }
    }
    function sendNewParams(json){
        let p=json.params
        let ms=new Date(Date.now()).getTime()
        let n=p.n
        let d=p.d
        let m=p.m
        let a=p.a
        let h=p.h
        let min=p.min
        let gmt=p.gmt
        let lat=p.lat
        let lon=p.lon
        let alt=p.alt
        let ciudad=p.c

        //let url=apps.host
        //let url=zcsfdm.host
        let url=r.server+':8100'
        url+='/zool/saveZoolParams'
        url+='?n='+n
        url+='&d='+d
        url+='&m='+m
        url+='&a='+a
        url+='&h='+h
        url+='&min='+min
        url+='&gmt='+gmt
        url+='&lat='+lat
        url+='&lon='+lon
        url+='&alt='+alt
        url+='&ciudad='+ciudad
        url+='&ms='+ms
        url+='&adminId='+apps.zoolUserId
        url+='&msReq='+ms
        url+='&msmod='+ms
        url+='&tipo=vn'
        url=url.replace(/\n/g, '')
        url=url.replace(/\r/g, '')
        url=url.replace(/ /g, '%20')
        //console.log('Url  saveZoolParams: '+url)
        //log.lv('Url  saveZoolParams: '+url)
        getRD(""+url+"", saveZoolParams)
    }
    //<-- Save Zooland Params

    //--> Network
    function getRD(url, item){//Remote Data
        var request = new XMLHttpRequest()
        request.open('GET', url, true);
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status && request.status === 200) {
                    /*let d=request.responseText
                    if(d.indexOf('redirected')>=0&&d.indexOf('</html>')>=0){
                        let m0=d.split('</html>')
                         item.setData(m0[1], true)
                    }else{
                         item.setData(d, true)
                    }*/
                    item.setData(parseRetRed(request.responseText), true)
                } else {
                    item.setData("Url: "+url+" Status:"+request.status+" HTTP: "+request.statusText, false)
                }
            }
        }
        request.send()
    }
    function parseRetRed(d){
        if(d.indexOf('redirected')>=0&&d.indexOf('</html>')>=0){
            let m0=d.split('</html>')
            return m0[1]
        }else{
            return d
        }
    }
    //<-- Network
}
