import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
import ".."
import "qrc:/ModelsControls"

Item {
    id:root
    opacity: 0

    Behavior on opacity{
        NumberAnimation{
            duration: 200
        }
    }

    signal componentChoosed(int type, string path, int width, int height)
    onComponentChoosed: hide()

    readonly property bool isVisible: root.opacity == 1 ? true : false

    function show(){
        opacity = 1;
    }

    function hide(){
        opacity = 0;
    }

    function getPathByType(type){
        return root.pathArray[type];
    }

    property var pathArray:[
    "qrc:/ModelsControls/JoySteering.qml",
        "qrc:/ModelsControls/JoyMoving.qml",
            "qrc:/ModelsControls/Buttons.qml",
                "qrc:/ModelsControls/SliderH.qml"]

    Rectangle {
        id: background
        color: ConstList_Color.darkBackground
        anchors.fill: parent
        opacity: 0.8
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            hide();
        }
    }

    property var previewSizeSteering:{"width": Units.dp(160)}
    property var previewSizeMoving:{"width": Units.dp(160)}
    property var previewSizeButtons:{"width": Units.dp(200), "height":Units.dp(100)}
    property var previewSizeSliderH:{"width": Units.dp(400), "height":Units.dp(80)}

    Flickable {
        id: flickable
        height: column.height
        anchors.right: parent.right
        anchors.rightMargin: column.spacing
        anchors.left: parent.left
        anchors.leftMargin: column.spacing
        anchors.verticalCenter: parent.verticalCenter
        contentWidth: column.width;
        contentHeight: column.height

        Row {
            id: column
            width: root.previewSizeSteering.width + root.previewSizeMoving.width + root.previewSizeButtons.width + root.previewSizeSliderH.width + spacing * 3
            height: Units.dp(160)
            anchors.verticalCenter: parent.verticalCenter
            spacing: Units.dp(60)

            Loader{
                anchors.verticalCenter: parent.verticalCenter
                sourceComponent: joySteering
            }

            Loader{
                anchors.verticalCenter: parent.verticalCenter
                sourceComponent: joyMoving
            }

            Loader{
                anchors.verticalCenter: parent.verticalCenter
                sourceComponent: buttons
            }

            Loader{
                anchors.verticalCenter: parent.verticalCenter
                sourceComponent: hslider
            }
        }

    }

    Component{
        id: joySteering
        JoySteering {
            width: root.previewSizeSteering.width
            height: root.previewSizeSteering.width
            editorMode: false
            paletteMode: true
            MouseArea{
                anchors.fill: parent
                onClicked: root.componentChoosed(0,root.pathArray[0], Units.dp(140),Units.dp(140))
            }
            Label{
                text: ConstList_Text.control_name_steering
                font.pixelSize: Qt.application.font.pixelSize * 1.5
                font.weight: Font.Medium
                anchors.bottomMargin: height
                anchors.bottom: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    Component{
        id: joyMoving
        JoySteering {
            width: root.previewSizeMoving.width
            height: root.previewSizeMoving.width
            editorMode: false
            paletteMode: true
            MouseArea{
                anchors.fill: parent
                onClicked: root.componentChoosed(1,root.pathArray[1], Units.dp(140),Units.dp(140))
            }
            Label{
                text: ConstList_Text.control_name_moving
                font.pixelSize: Qt.application.font.pixelSize * 1.5
                font.weight: Font.Medium
                anchors.bottomMargin: height
                anchors.bottom: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    Component{
        id: buttons
        Buttons {
            width: root.previewSizeButtons.width
            height: root.previewSizeButtons.height
            editorMode: false
            paletteMode: true
            MouseArea{
                anchors.fill: parent
                onClicked: root.componentChoosed(2,root.pathArray[2], Units.dp(160),Units.dp(80))
            }
            Label{
                text: ConstList_Text.control_name_buttons
                font.pixelSize: Qt.application.font.pixelSize * 1.5
                font.weight: Font.Medium
                anchors.bottomMargin: height
                anchors.bottom: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    Component{
        id:hslider
        SliderH{
            width: root.previewSizeSliderH.width
            height: root.previewSizeSliderH.height
            editorMode: false
            paletteMode: true
            MouseArea{
                anchors.fill: parent
                onClicked: root.componentChoosed(3,root.pathArray[3], Units.dp(250),Units.dp(50))
            }
            Label{
                text: ConstList_Text.control_name_hslider
                font.pixelSize: Qt.application.font.pixelSize * 1.5
                font.weight: Font.Medium
                anchors.bottomMargin: height
                anchors.bottom: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
