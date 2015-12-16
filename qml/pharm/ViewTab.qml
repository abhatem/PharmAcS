import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0
import QtQuick.Layouts 1.0
import PharmAcS.DataEngine 1.0
import PharmItem 1.0
import "viewTab_script.js" as Script

Rectangle {
    id: root
    function updateListModel() {
        Script.updateListModel();
    }

    ListModel {
        id: lm
    }

    Image {
        id: item_img
        anchors.centerIn: parent
        visible: false;
        z: 3
    }
    SplitView {
        id: view
        anchors.fill: parent
        orientation: Qt.Horizontal

        TableView {
            id: tv
//            anchors.fill: parent
//            anchors.right: parent.right
//            anchors.rightMargin: 300

            width: parent.width*(3/4)
            TableViewColumn {role: "barcode"; title: "Barcode"; width: 100}
            TableViewColumn {role: "name"; title: "Name"; width: 100}
            TableViewColumn {role: "sellingPrice"; title: "Price"; width: 200}
            TableViewColumn {role: "invoicePrice"; title: "Invoice Price"; width: 200}
            model: lm
            //        width: 180
            //        height:  200
            //        delegate: Text {
            //            text:  barcode + ": " + name
            //        }
            onClicked:  {
//                console.log("clicked row: ", row);
//                console.log(PharmData.pharmItems[row].placePath);
                view_form.pharmItem = PharmData.pharmItems[row]
                item_img.visible = true;
            }
        }

        ViewForm {
            id: view_form
//            anchors.right: parent.right
//            anchors.rightMargin: 8
//            anchors.left: tv.right
//            anchors.leftMargin: 8
//            anchors.top: parent.top
//            anchors.topMargin: 8
//            anchors.bottom: parent.bottom
//            anchors.bottomMargin: 8
            width: parent.width*(1/4)
            border.color: "darkblue"
            border.width: 1
        }
    }
    PharmItem {
        id: dummy
    }

    Component.onCompleted: Script.updateListModel();
    onVisibleChanged: Script.updateListModel();

}
