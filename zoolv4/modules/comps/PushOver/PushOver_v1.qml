import QtQuick 2.0

Item{
    id: r
    property var aMsgs: []

    Component.onCompleted: {
        if(u.folderExist('/home/ns'))return
        let s='Zool Iniciado!\n'
        s+='Versión: '+u.getFile('version')
        sendMessage(s)
    }
    function sendMessage(msg){
        var xhr = new XMLHttpRequest();
        var url = "https://api.pushover.net/1/messages.json";
        var params = "token=a7biiubgzgcjjm4pdp8s8wghcxh81k" +
                "&user=udj7y27mkawju5mtmph7r7qxr6ng7b" +
                "&message=" + encodeURIComponent(msg);

        xhr.open("POST", url, true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    //log.lv("Notificación enviada exitosamente:" + xhr.responseText);
                    // Aquí podrías mostrar un mensaje al usuario
                    if(r.aMsgs.indexOf(msg)<0){
                        r.aMsgs.push(msg)
                    }
                } else {
                    //log.lv("Error al enviar la notificación:" + xhr.status, xhr.responseText);
                    // Aquí podrías mostrar un mensaje de error al usuario
                    //return false
                }
            }
        };

        xhr.send(params);
    }
}
