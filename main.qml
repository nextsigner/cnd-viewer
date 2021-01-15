import QtQuick 2.12
import QtGraphicalEffects 1.12
import QtQuick.Controls 2.0
import Qt.labs.folderlistmodel 2.12

ApplicationWindow {
    id: app
    visible: true
    visibility: "Maximized"
    color: 'green'
    title: 'cndviewer'
    property int fs: width*0.03
    property string url
    property int mod: 0
    FolderListModel{
        folder: 'file:///home/ns/temp-screenshots'
        showDirs: false
        showFiles: true
        showHidden: false
        nameFilters: [ "*.png" ]
        sortReversed: true
        sortField: FolderListModel.Time
        onCountChanged: {
            //console.log(get(count-1, 'fileName'))
            app.url='/home/ns/temp-screenshots/'+get(count-1, 'fileName')
            console.log('Count app.url='+app.url)
            tReload.start()
            //img.source=app.url
            //img2.source=app.url
            let fn=app.url.replace('cap_', '').replace('.png', '')
            let jsonFileName=fn+'.json'//'/home/ns/temp-screenshots/'+ms+'.json'
            console.log('FileName: '+jsonFileName)
            let jsonFileData=unik.getFile(jsonFileName)
            //console.log(jsonFileData)
            let jsonData=JSON.parse(jsonFileData)
            let nom=jsonData.params.n.replace(/_/g, ' ')
            let vd=jsonData.params.d
            let vm=jsonData.params.m
            let va=jsonData.params.a
            let vh=jsonData.params.h
            let vmin=jsonData.params.min
            let vgmt=jsonData.params.gmt
            let vlon=jsonData.params.lon
            let vlat=jsonData.params.lat
            let vCiudad=jsonData.params.ciudad.replace(/_/g, ' ')
            let textData=''
                +'<b>'+nom+'</b>'
                +'<p style="font-size:20px;">'+vd+'/'+vm+'/'+va+' '+vh+':'+vmin+'hs GMT '+vgmt+' <b>Edad:</b> '+getEdad(""+va+"/"+vm+"/"+vd+" "+vh+":"+vmin+":00")+'</p>'
                +'<p style="font-size:20px;"><b> '+vCiudad+'</b></p>'
                +'<p style="font-size:20px;"> <b>long:</b> '+vlon+' <b>lat:</b> '+vlat+'</p>'
            xNombre.nom=textData
        }
    }
    Timer{
        id: tUpdate
        running: true
        repeat: true
        interval: 1000
        onTriggered: {
            let d=new Date(Date.now())
            img.source=app.url+'?r='+d.getTime()
            img2.source=app.url+'?r='+d.getTime()
        }
    }
    Timer{
        id: tReload
        running: false
        repeat: false
        interval: 3000
        onTriggered: {
            let d=new Date(Date.now())
            img.source=app.url+'?r='+d.getTime()
            img2.source=app.url+'?r='+d.getTime()
        }
    }

    Item{
        id: xApp
        anchors.fill: parent
        Rectangle{
            id: xImg
            width: parent.width
            height: parent.height
            border.width: 8
            border.color: app.mod===0?'red':'yellow'
            Image{
                id: img
                source: app.url
                width: xApp.width
                fillMode: Image.PreserveAspectFit
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: xApp.width*0.25
                property bool mov: false
                onStatusChanged: {
                    //Image.Error
                    if(status===Image.Error){
                        tReload.start()
                    }
                    if(status===Image.Ready){
                        //Qt.quit()
                        img2.x=0-600
                        img2.y=0-img2.height*2+xMira.height
                    }
                }
                onXChanged:{
                    mov=true
                    trm.restart()
                }
                onYChanged:{
                    mov=true
                    trm.restart()
                }
                Timer{
                    id: trm
                    running: false
                    repeat: false
                    interval: 100
                    onTriggered: {
                        img.mov=false
                    }
                }
                Behavior on x{
                    NumberAnimation{duration:750;easing.type: Easing.InOutCubic}
                }
                Behavior on y{
                    NumberAnimation{duration:750;easing.type: Easing.InOutCubic}
                }
                MouseArea{
                    anchors.fill: parent
                    drag.target: parent
                    drag.axis: Drag.XAndYAxis
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    onClicked: {
                        info.text=mouseX
                        img2.x=0-mouseX*2+img2.parent.width*0.5
                        img2.y=0-mouseY*2+img2.parent.height*0.5
                        xMiraDer.x=mouseX+img.anchors.horizontalCenterOffset-xMiraDer.width*0.5
                        xMiraDer.y=mouseY-xMiraDer.height*0.5+img.y//app.fs*2
                    }
                }
            }
            FastBlur {
                id: fb
                anchors.fill: img
                source: img
                radius: 2
            }
            BrightnessContrast {
                anchors.fill: fb
                source: fb
                brightness: 0.35
                contrast: 0.7
            }
            XMira{
                id: xMiraDer
                w:app.fs*1.5
                mov: false//enabled?img.mov:true
                property bool enabled: true
            }
        }

        //        XCentralCircle{
        //            id: xCentralCircle
        //            opacity: 0.3
        //        }

        Item{
            id: xAreaFlecha
            anchors.fill: parent
            visible: app.mod===1
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    xFlecha.x=mouseX
                    xFlecha.y=mouseY
                }
            }
            Item{
                id: xFlecha
                width: imgFlecha.width
                height: 2
                opacity: visible?1.0:0.0
                Behavior on opacity{NumberAnimation{duration: 250}}
                Behavior on x{
                    NumberAnimation{duration:750;easing.type: Easing.InOutCubic}
                }
                Behavior on y{
                    NumberAnimation{duration:750;easing.type: Easing.InOutCubic}
                }
                Image{
                    id: imgFlecha
                    source: 'flecha.png'
                    width: app.fs
                    fillMode: Image.PreserveAspectFit
                }
            }
        }
        //        Rectangle{
        //            id: circBorde
        //            width: xCentralCircle.rectCentral.width
        //            height: xCentralCircle.rectCentral.height
        //            border.width: 1
        //            border.color: 'red'
        //            anchors.centerIn: parent
        //            //radius: width*0.5
        //            color: 'transparent'
        //            visible: false
        //        }
        Item{
            id: xImg2
            width: parent.width*0.5
            height: parent.height
            clip: true
            Image{
                id: img2
                //visible: false
                source: img.source
                width: img.width*2
                height: img.height*2
                //fillMode: Image.PreserveAspectFit
                property bool mov: false
                onXChanged:{
                    mov=true
                    trm.restart()
                }
                onYChanged:{
                    mov=true
                    trm.restart()
                }
                Behavior on x{
                    NumberAnimation{duration:750;easing.type: Easing.InOutCubic}
                }
                Behavior on y{
                    NumberAnimation{duration:750;easing.type: Easing.InOutCubic}
                }
                FastBlur {
                    id: fb2
                    anchors.fill: img2
                    source: img2
                    radius: 2
                }
                BrightnessContrast {
                    anchors.fill: fb2
                    source: fb2
                    brightness: 0.35
                    contrast: 0.7
                }


                MouseArea{
                    anchors.fill: parent
                    drag.target: parent
                    drag.axis: Drag.XAndYAxis
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    onClicked: {
                        info.text=mouseX
                        /*if(mouse.modifiers) {
                            xMira.enabled=!xMira.enabled
                        }else{
                            img.x=0-mouseX+img.width*0.5
                            img.y=0-mouseY+img.height*0.5-40//(720-534)
                        }*/
                    }
                }
            }
            Rectangle{
                anchors.fill: parent
                color: 'transparent'
                border.width: 2
                border.color: 'red'
                clip: true
            }
            XMira{
                id: xMira
                w:app.fs*2.5
                anchors.fill: parent
                mov: false//enabled?img.mov:true
                property bool enabled: true
            }
        }
        Text{
            id: info
            text: app.mod
            font.pixelSize: 60
            color: 'red'
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false
        }
        XNombre{id: xNombre}
    }
    Shortcut{
        sequence: 'Ctrl+Up'
        onActivated: {
            if(app.mod===0){
                app.mod=1
            }else{
                app.mod=0
                xFlecha.x=0-app.fs*3
                xFlecha.y=0-app.fs*3
            }
        }
    }
    Shortcut{
        sequence: 'Esc'
        onActivated: Qt.quit()
    }
    Shortcut{
        sequence: 'Up'
        onActivated: img.y-=4
    }
    Shortcut{
        sequence: 'Down'
        onActivated: img.y+=4
    }
    function getEdad(dateString) {
        let hoy = new Date()
        let fechaNacimiento = new Date(dateString)
        let edad = hoy.getFullYear() - fechaNacimiento.getFullYear()
        let diferenciaMeses = hoy.getMonth() - fechaNacimiento.getMonth()
        if (
                diferenciaMeses < 0 ||
                (diferenciaMeses === 0 && hoy.getDate() < fechaNacimiento.getDate())
                ) {
            edad--
        }
        return edad
    }
}
