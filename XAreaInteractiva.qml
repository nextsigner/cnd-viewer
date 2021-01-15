import QtQuick 2.0

Rectangle {
    id: r
    width: 100
    height: 500
    color: 'transparent'
    border.width: 4
    border.color: 'pink'
    Rectangle {
        id: rueda
        width: app.fs*14
        height: width
        radius: width*0.5
        color: 'transparent'
        border.width: 0//poner en 3 para ver si está centrado
        border.color: 'blue'
        anchors.centerIn: r
        anchors.horizontalCenterOffset: app.fs*0.77
    }
    Component{
        id: sc
        Rectangle{
            id: compSen
            width: 2//rueda.width
            height: rueda.width
            anchors.centerIn: parent
            rotation: 45
            color: 'transparent'
            property string info1: '???'
            property string info2: '???'
            property string info3: '???'
            Rectangle{
                id: info
                width: app.fs*7.24
                height: width
                radius: width*0.5
                border.width: 4
                border.color: 'red'
                clip: true
                anchors.centerIn: parent
                rotation: 0-parent.rotation
                property bool show: false
                opacity: show?1.0:0.0
                Behavior on opacity {
                    NumberAnimation{duration: 200}
                }
                Column{
                    spacing: app.fs*0.1
                    anchors.centerIn: parent
                    Text {
                        id: i1
                        color: 'red'
                        font.pixelSize: app.fs*1.5
                        text: compSen.info1
                        width: parent.width-app.fs
                        wrapMode: Text.WordWrap
                        textFormat: Text.RichText
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        id: i2
                        color: 'red'
                        font.pixelSize: app.fs*2
                        text: compSen.info2
                        width: parent.width-app.fs*1.5
                        wrapMode: Text.WordWrap
                        textFormat: Text.RichText
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        id: i3
                        color: 'red'
                        font.pixelSize: app.fs*2
                        text: compSen.info3
                        width: parent.width-app.fs
                        wrapMode: Text.WordWrap
                        textFormat: Text.RichText
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
            Rectangle{
                width: 6
                height: parent.height/2
                color: 'transparent'
                anchors.horizontalCenter: parent.right
                //anchors.left: parent.left
                property bool show: false
                Rectangle{
                    anchors.fill: parent
                    color: 'transparent'
                    opacity: info.show?1.0:0.5
                    Behavior on opacity {
                        NumberAnimation{duration: 200}
                    }
                }
                MouseArea{
                    id: maSC
                    anchors.fill: parent
                    hoverEnabled: true
                    onDoubleClicked: {
                        maSC.enabled=false
                        tShowMASC.restart()
                    }
                    onEntered: info.show=true
                    onExited: info.show=false
                    Timer{
                        id: tShowMASC
                        running: false
                        repeat: false
                        interval: 2000
                        onTriggered: maSC.enabled=true
                    }
                }
            }
        }
    }
    Component.onCompleted: {
        //loadData()
    }
    function loadData(){
        let fn=app.url.replace('cap_', '').replace('.png', '')
        let jsonFileName=fn+'.json'//'/home/ns/temp-screenshots/'+ms+'.json'
        console.log('FileName SC: '+jsonFileName)
        let jsonFileData=unik.getFile(jsonFileName)
        //console.log(jsonFileData)
        let jsonData=JSON.parse(jsonFileData)
        //let numSigno=app.objSignsNames.indexOf()

        let sObj=''
        let obj

        sObj='sun'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='moon'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='mercury'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='venus'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='mars'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='jupiter'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='saturn'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='uranus'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='neptune'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='pluto'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='n'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='s'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='hiron'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='proserpina'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='selena'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)

        sObj='lilith'
        obj=jsonData.psc[sObj]
        addSC(sObj, obj.s, obj.g, obj.m, (obj.rh).toUpperCase(), jsonData)
    }

    function addSC(c, s, g, m, h, j){
        let numSigno=app.objSignsNames.indexOf(j.pc.h1.s)
        let gAsc=j.pc.h1.g+numSigno*30
        console.log('NumSig:'+numSigno)
        console.log('gAsc:'+gAsc)
        let vRCuerpo=30*getSigIndex(s)
        let gTotSig=0-vRCuerpo+gAsc-g-90//gAsc-(app.objSignsNames.indexOf(s)+1)*30+g//+(360-gAsc)
        console.log('-->'+c+' '+s+' '+g+' '+app.objSignsNames.indexOf(s))
        let fs=parseInt(app.fs*1.5)
        let fs2=parseInt(fs *0.7)
        console.log('Planeta: '+app.planetas[app.planetasRes.indexOf(c)])
        let info1='<b>'+app.planetas[app.planetasRes.indexOf(c)]+'</b>'
        let info2='<b style="font-size:'+fs+'px">'+app.signos[app.objSignsNames.indexOf(s)]+'</b>'
        let info3='<b style="font-size:'+fs2+'px">°'+g+'\''+m+' Casa '+h+'</b>'
        let comp=sc
        let obj=comp.createObject(rueda, {rotation: gTotSig, info1:info1,  info2:info2, info3:info3})
    }
    function getSigIndex(s){
        let ms=['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']
        return ms.indexOf(s)
    }
}
