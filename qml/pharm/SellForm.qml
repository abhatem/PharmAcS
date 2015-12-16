import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import "sellForm_script.js" as Script

Rectangle {
    id: root
    function clearBarcodeTxt() {
        barcode_txt.text = ""
    }

    signal addToBill(var barcode);
    signal saveBill(var disc);
    ColumnLayout {
        spacing: 4
        anchors.fill: parent
        GroupBox {
            id: barcode_group
            title: "Item"
            Layout.alignment: Qt.AlignTop
            Layout.minimumWidth: root.width - 4
            anchors.left: parent.left
            anchors.leftMargin: 4

            TextField {
                id: barcode_txt
                placeholderText: "Barcode"
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.topMargin: 4
                anchors.rightMargin: 4
                anchors.leftMargin: 4
                focus: true;
                Keys.onPressed: {
                    if (event.key === Qt.Key_Return) {
                        addToBill(barcode_txt.text)
                        event.accepted = true;
                    }
                }

                Component.onCompleted: forceActiveFocus();
            }

            Button {
                id: add_btn
                text: "Add"
                anchors.top: barcode_txt.bottom
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.topMargin: 4
                anchors.rightMargin: 4
                anchors.leftMargin: 4
                onClicked: addToBill(barcode_txt.text);
            }
        }

        GroupBox {
            id: sell_group
            title: "Sell"

            Layout.minimumWidth: parent.width-4
            anchors.left: parent.left
            anchors.leftMargin: 4

            anchors.top: barcode_group.bottom
            anchors.topMargin: 4
            Label {
                id: discription_lbl
                text: "Bill discription"
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.topMargin: 4
                anchors.rightMargin: 4
                anchors.leftMargin: 4
                height: 100
                Layout.preferredHeight: 100
                Layout.minimumHeight: 100
                TextArea {
                    id: discription_area
                    anchors.top: parent.top
                    anchors.topMargin: 20
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom

                }
            }

            Button {
                id: sell_btn
                text: "Sell"
                y: discription_lbl.y+discription_lbl.height+4
                anchors.right: parent.right
                anchors.left: parent.left
//                anchors.topMargin: 4
                anchors.rightMargin: 4
                anchors.leftMargin: 4
                onClicked: saveBill(discription_area.text);
            }
        }
    }
}
