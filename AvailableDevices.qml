import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import ".."

Item {
    id:root

    property bool isNotEmpty: (deviceModel.count > 0);
    property bool hubChoosed: (listView.currentIndex >= 0)
    clip: true

    property string currentHubAddress:""

    function highlightIfPossible(){
        for(var i = 0; i < deviceModel.count; i++){
            if(deviceModel.get(i).address === linkToControl.chAddress){
                listView.currentIndex = i;
                root.currentHubAddress = deviceModel.get(i).address;
                return;
            }
        }
        listView.currentIndex = -1;
    }

    function loadDeviceList(){

        deviceModel.clear();
        var count = cpp_Controller.getDevicesCount();
        for(var i = 0; i < count; i++){
            var list = cpp_Controller.getDevicesListQML();
            deviceModel.append(list);
        }

        highlightIfPossible();
    }

    Rectangle {
        id: rectangle
        color: "#00000000"
        border.color: Material.primary
        border.width: Units.dp(2)
        anchors.fill: parent
        radius:Units.dp(4)
        visible: false
    }

    Label {
        id: label
        height: Units.dp(26)
        text: qsTr("No connected hubs")
        anchors.right: parent.right
        anchors.rightMargin: Units.dp(200)
        anchors.left: parent.left
        anchors.leftMargin: Units.dp(200)
        fontSizeMode: Text.VerticalFit
        anchors.verticalCenter: parent.verticalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: Qt.application.font.pixelSize
        visible: !isNotEmpty
    }

    ListView {
        id: listView
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: Units.dp(10)
        anchors.topMargin: Units.dp(10)
        clip: false
        anchors.fill: parent
        model:deviceModel
        spacing: Units.dp(10)
        delegate:     Item {
            height: Units.dp(24)
            width: listView.width/1.1
            anchors.horizontalCenter: parent.horizontalCenter
            property bool isCur : ListView.isCurrentItem
            CustomPane{
                id: customPane
                anchors.fill: parent
                Material.background: isCur ? Material.accent : Material.primary
                Material.elevation:Units.dp(1)
                radius: height/2
            }

            Label{
                text:qsTr("Hub ")+ (index+1)+ " - " + name
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent
                font.pixelSize: Qt.application.font.pixelSize
            }

            MouseArea{
                anchors.fill: parent
                onClicked:{
                    listView.currentIndex = index;
                    linkToControl.chName = deviceModel.get(index).name;
                    linkToControl.chAddress = deviceModel.get(index).address;
                    root.currentHubAddress = deviceModel.get(index).address;
                }
            }
        }
    }
    
    Rectangle {
        height: Units.dp(2)
        radius: height/2
        color: Material.primary
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
    }

    ListModel{
        id:deviceModel
    }

    Rectangle {
        height: Units.dp(2)
        radius: height/2
        color: Material.primary
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.left: parent.left
    }
}

