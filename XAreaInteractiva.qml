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
        border.width: 3
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
            property string info: '???'
            Rectangle{
                id: info
                width: app.fs*8
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
                Text {
                    color: 'red'
                    font.pixelSize: app.fs*2
                    text: compSen.info
                    width: parent.width-app.fs
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                }
            }
            Rectangle{
                width: 8
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

        addSC('sun', jsonData.psc.sun.s, jsonData.psc.sun.g, (jsonData.psc.sun.rh).toUpperCase(), jsonData)
        addSC('moon', jsonData.psc.moon.s, jsonData.psc.moon.g, (jsonData.psc.moon.rh).toUpperCase(), jsonData)
        addSC('mercury', jsonData.psc.mercury.s, jsonData.psc.mercury.g, (jsonData.psc.mercury.rh).toUpperCase(), jsonData)
    }

    function addSC(c, s, g, h, j){
        let numSigno=app.objSignsNames.indexOf(j.pc.h1.s)
        let gAsc=j.pc.h1.g+numSigno*30
        console.log('NumSig:'+numSigno)
        console.log('gAsc:'+gAsc)
        let vRCuerpo=30*getSigIndex(s)
        let gTotSig=0-vRCuerpo+gAsc-g-90//gAsc-(app.objSignsNames.indexOf(s)+1)*30+g//+(360-gAsc)
        console.log('-->'+c+' '+s+' '+g+' '+app.objSignsNames.indexOf(s))
        let fs=parseInt(app.fs*2)
        let fs2=parseInt(fs *0.5)
        let info='<b>'+app.planetas[app.planetasRes.indexOf(c)]+'</b>'
            +'<b style="font-size:'+fs2+'px">'+app.signos[app.objSignsNames.indexOf(s)]+'</b><br />'
            +'<b style="font-size:'+fs2+'px">°'+g+'\'00</b>'
            +'<b style="font-size:'+fs2+'px">Casa '+h+'</b>'
        let comp=sc
        let obj=comp.createObject(rueda, {rotation: gTotSig, info:info})
    }
    function getSigIndex(s){
        let ms=['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']
        return ms.indexOf(s)
    }
}
