import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Dialogs 1.0




Rectangle {
    id: root
    width: 400
    height: 700

    Column {
        id: lay
        anchors.fill: parent
        Label {
            id: addItem_lbl
            text: "Add Item"
            style: Text.Raised
            wrapMode: Text.NoWrap
            horizontalAlignment: Text.AlignHCenter
            font.family: "DejaVu Sans"
            color: "blue"
            font.bold: true
            font.pointSize: 32
            x: 147
            width: 260
        }

        TextField {
            id: barcode_txt
            x: 147
            y: -5
            width: 260
            placeholderText: "Barcode"
        }

        TextField {
            id: name_txt
            x: 147
            y: 44
            width: 260
            placeholderText: "Name"
        }

        TextField {
            id: scientificName_txt
            x: 147
            y: 25
            width: 260
            placeholderText: "Scientific Name"
        }

        TextField {
            id: tags
            width: 260
            x: 147
            font.family: "DejaVu Sans"
            placeholderText: "Tags"
        }

        SpinBox {
            id: sellingPrice_spin
            x: 147
            y: 90
            width: 260
            prefix: "Selling Price: "
            suffix: " (IQD)"
            stepSize: 50
            maximumValue: 99999999999;
        }

        SpinBox {
            id: invoicePrice_spin
            x: 147
            y: 114
            width: 260
            suffix: " (IQD)"
            stepSize: 50
            prefix: "Invoice Price: "
            maximumValue: 99999999999;
        }

        SpinBox {
            id: amount_spin
            x: 147
            y: 106
            width: 260
            suffix: " (Item)"
            prefix: "Amount: "
        }

        SpinBox {
            id: bonus_spin
            x: 147
            y: 125
            width: 260
            suffix: " (Item"
            prefix: "Bonus: "
        }

        Button {
            id: imagePath_btn
            x: 147
            y: 181
            width: 260
            text: "Image Path..."
            tooltip: "choose an image for " + name_txt.text
            FileDialog {
                id: imagePath_dlg
                title: "Choose an image for " + name_txt.text
            }

            onClicked: {
                imagePath_dlg.visible = true;
            }
        }


        Label {
            id: decoy_lbl
            text: " "
        }

        Label {
            id: expiry_lbl
            font.family: "DejaVu Sans"
            text: "Expiry Date"
            color: "darkgrey"
            width: 260
            x: 240
        }

        Row {
            id: expiry_lay
            width: 260
            x: 177
            ComboBox {
                id: year_box
                model: {

                    var y = new Date().getFullYear();
                    var lst = [];
                    for(var i = y; i < y + 10; i++) {
                        lst.push(i)
                    }
                    model = lst;

                }
                currentIndex: 0
            }

            ComboBox {
                id: month_box
                currentIndex: {
                    var m = new Date().getMonth();
                    month_box.currentIndex = m;
                }
                model: ['January', 'Febuary', 'March', 'April', 'May', 'June', 'July', 'August', 'September',
                       'October', 'November', 'December']
            }
        }

        Label {
            id: decoy_lbl2
            text: " "
        }

        Label {
            id: discription_lbl
            font.family: "DejaVu Sans"
            text: "Discription"
            color: "darkgrey"
            width: 260
            x: 240
        }

        TextArea {
            id: discription_txt
            font.family: "Dejavu Sans"
            width: 260
            x: 147
        }

        Label {
            id: decoy_lbl3
            text: " "
        }

        Button {
            id: add_btn
            x: 147
            width: 260
            text: "Add"
        }
    }
}
