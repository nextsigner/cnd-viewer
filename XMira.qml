import QtQuick 2.0
import QtGraphicalEffects 1.12

Item {
    id: r
    width: w
    height: w
    property int w: app.fs
    property bool mov: false
    onMovChanged: {
        if(mov){
            mira.visible=false
        }
    }
    Rectangle{
        id: mira
        width: r.w
        height: width
        radius: width*0.5
        border.width: 6
        border.color: 'red'
        color: 'transparent'
        anchors.centerIn: parent
        Rectangle{
            width: parent.width+2
            height: width
            radius: width*0.5
            border.width: 2
            border.color: 'white'
            color: 'transparent'
            anchors.centerIn: parent
        }
    }
    Timer{
        running: true
        repeat: true
        interval: 350
        onTriggered: {
            mira.visible=!mira.visible
        }
    }
}
