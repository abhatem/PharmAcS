import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.LocalStorage 2.0
import PharmItem 1.0
import PharmData 1.0

Rectangle {
    id: root
    width: 360
    height: 360
    color: "black"
    gradient: Gradient {
        GradientStop {
            position: 0.00;
            color: "#00ff00";
        }
        GradientStop {
            position: 0.79;
            color: "#000000";
        }
    }
    border.color: "#2f29e0"

    PharmItem {
        id: azi
        barcode: "555"
        name: "azi-once"
        scientificName: "azithromicin"
        imagePath: "hello"
        sellingPrice: 1000
        invoicePrice: 750
        amount: 10
        expiryDate: new Date()
        discription: "for colds"
        tags: ["cold", "flu"]
        pos: [1, 2, 3]
    }
    PharmData {id:data}

    PharmItem {
        id: par
        name: "paracetamol"
        sellingPrice: azi.sellingPrice
    }

    Text {
        text: qsTr(par.sellingPrice.toString())
        anchors.centerIn: parent
    }

    ListModel {
        id: currentBill
    }


    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }

        AddForm {
            id: add_f
            opacity: 0
        }

        Button {
            id: button1
            x: 267
            y: 325
            text: "Button"
            onClicked: {
                add_f.opacity = 1;
            }
        }
    }

    Component.onCompleted:
    {
        console.log(data.pharmItems[0].tags[0]);
    }
}
