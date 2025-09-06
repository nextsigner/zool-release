import QtQuick 2.0

Item{
    id: r
    property string folderRoot: 'modules/ZoolDataSheet'
    function getDataFromFile(file){
        let fn=r.folderRoot+'/'+file
        return u.getFile(fn)
    }
    function getKeyWordsBodiesListData(numAstro){
        let a = []
        let fn=r.folderRoot+'/bodies_list_data/astro_naipe_'+zm.aBodiesFiles[numAstro]+'.txt'
        //console.log('0::: '+fn)
        let data=u.getFile(fn)
        //console.log('1::: '+data)
        let lines=data.split('\n')
        for(var i=0;i<lines.length;i++){
            if(lines[i].indexOf(':')>0){
                let m0=lines[i].split(':')
                let m1=m0[0].split('.')
                a.push(m1[1])
            }
        }
        return a
    }
    function getKeyWordsSignsListData(is){
        let a = []
        let fn=r.folderRoot+'/bodies_list_data/'+zm.aSignsLowerStyle[is]+'.txt'
        let data=u.getFile(fn)
        //console.log(data)
        let lines=data.split('\n')
        for(var i=0;i<lines.length;i++){
            if(lines[i].indexOf(':')>0){
                let m0=lines[i].split(':')
                let m1=m0[0].split('.')
                a.push(m1[1])
            }
        }
        return a
    }
    function getKeyWordsHousesListData(h){
        let a = []
        let fn=r.folderRoot+'/bodies_list_data/casa_'+h+'.txt'
        let data=u.getFile(fn)
        let lines=data.split('\n')
        for(var i=0;i<lines.length;i++){
            if(lines[i].indexOf(':')>0){
                let m0=lines[i].split(':')
                let m1=m0[0].split('.')
                a.push(m1[1])
            }
        }
        return a
    }
}
