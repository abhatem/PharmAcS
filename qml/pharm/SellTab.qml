import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import PharmBill 1.0
import PharmAcS.DataEngine 1.0
import "sellTab_script.js" as Script


Rectangle {
    id: root
    anchors.fill: parent
    ListModel {
        id: lm
    }

    MBox {
        id: noMoreItems_box
        parent: root.parent
        property var amount;
        property var name;
        function show(arg_name, arg_amount) {
            name = arg_name;
            amount = arg_amount;
            visible = true;
        }

        titleText: "No more items"
        contentText: "You only have " + amount + " item(s) of " + name
        buttonState: "OK"
        boxHeight: 200
        boxWidth: 400

    }

    PharmBill {
        id: pb
        returned: false;
    }

    SplitView {
        id: sView
        anchors.fill: parent
        orientation: Qt.Horizontal
        TableView {
            id: tabView
            width: root.width * (3/4)
            Layout.minimumWidth: root.width * (1/2)
            model: lm
            TableViewColumn {role: "name"; title: "Name"; width: tabView.width/5;}
            TableViewColumn {role: "sellingPrice"; title: "Selling Price"; width: tabView.width/5}
            TableViewColumn {role: "amount"; title:  "Amount"; width: tabView.width/5}
            TableViewColumn {role: "totalPrice"; title: "Total Price"; width: tabView.width/5}
            TableViewColumn {role: "barcode"; title: "Barcode"; width: tabView.width/5}
//            TableViewColumn {role: "actions"; title: ""; width: tabView.width/6}
            itemDelegate: Item {
                SpinBox {
//                    property variant value: styleData.value
                    anchors.fill: parent
                    visible: tabView.getColumn(styleData.column).role === "amount" ? true : false
//                    value: tabView.getColumn(styleData.column).role === "amount" ? styleData.value : ""
//                    Component.onCompleted: console.log(styleData.value)
                    minimumValue: 1
                    maximumValue: Script.getPharmItem(lm.get(styleData.row).barcode).amount
                    value: tabView.getColumn(styleData.column).role === "amount" ? styleData.value : 0
                    onValueChanged: {
                        var item = lm.get(styleData.row)
                        item.amount = value
                        item.totalPrice = item.sellingPrice * item.amount
                    }
                }

                Text {
                    property variant value: styleData.value
                    anchors.fill: parent
                    visible: tabView.getColumn(styleData.column).role === "amount" ? false : true
                    text:  tabView.getColumn(styleData.column).role !== "amount" ?  styleData.value : 0
                }
            }
        }
        SellForm {
            id: sellForm
            width: root.width * (1/4)
            Layout.minimumWidth: 250
            onAddToBill: Script.addToBillList(barcode);
            onSaveBill: Script.saveBill(disc)
        }
    }
}

