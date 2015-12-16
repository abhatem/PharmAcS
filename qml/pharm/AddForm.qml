import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.0
//import PharmImage 1.0
import PharmItem 1.0
//import PharmData 1.0
import PharmAcS.DataEngine 1.0
import "storage.js" as Storage
import QtQuick.LocalStorage 2.0
import QtQuick.Controls.Styles 1.0
import QtQuick.Window 2.0
//import "pharmItem.js" as Pi
import "addForm_script.js" as Script

Rectangle {
    id: root
    property string barcode: barcode_txt.text
    property string name: name_txt.text
    property string scientificName: scientificName_txt.text
    property string tags: tags_txt.text
    property string discription: discription_area.text
    property url imageUrl
    property int sellingPrice: sellingPrice_spin.value
    property int invoicePrice: invoicePrice_spin.value
    property int amount: amount_spin.value
    property int bonus: bonus_spin.value
    property int year_index: expiry_lay.year
    property int month_index: expiry_lay.month
    property var year_model: expiry_lay.year_model
    property var month_model: expiry_lay.month_model
    property url placeUrl
    property int  posX
    property int posY

    property var place_frm


    function setPlace(posX_arg, posY_arg, placeUrl_arg) {
        posX = posX_arg;
        posY = posY_arg;
        placeUrl = placeUrl_arg;
        var placeStr = placeUrl.toString().slice(placeUrl.toString().lastIndexOf('/')+1);
        if(placeStr.length > 16)  placeStr = placeStr.substring(16) + "(Striped name)"
        place_btn.text = "Place: " + placeStr;
        console.log("root posX: ", posX);
        console.log("root posY: ", posY);
    }

//    width: 250
//    height: 768
    LayoutMirroring.enabled: false
    LayoutMirroring.childrenInherit: true
    ColumnLayout {
        id: lay
        anchors.fill: parent
        spacing: 4
        TextField {
            id: barcode_txt
            x: 267
            width: 250
            Layout.minimumWidth: 150
            Layout.preferredWidth: 250
            placeholderText: "Barcode"
            anchors.horizontalCenterOffset: 0
            anchors.top: parent.top
            anchors.topMargin: 8
            anchors.horizontalCenter: parent.horizontalCenter
        }

        TextField {
            id: name_txt
            x: 192
            width: 250
            Layout.minimumWidth: 150
            Layout.preferredWidth: 250
            placeholderText: qsTr("Name")
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 39
        }

        TextField {
            id: scientificName_txt
            x: 195
            width: 250
            Layout.minimumWidth: 150
            Layout.preferredWidth: 250;
            anchors.top: parent.top
            anchors.topMargin: 70
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: "Scientific Name"
        }

        TextField {
            id: tags_txt
            x: 195
            width: 250
            Layout.minimumWidth: 150
            Layout.preferredWidth: 250;
            placeholderText: "Tags"
            anchors.top: parent.top
            anchors.topMargin: 101
            anchors.horizontalCenter: parent.horizontalCenter
        }

        SpinBox {
            id: sellingPrice_spin
            x: 236
            width: 250
            Layout.minimumWidth: 150
            Layout.preferredWidth: 250;
            suffix: " (IQD)"
            maximumValue: 999999999
            stepSize: 50
            prefix: "Selling Price: "
            anchors.top: parent.top
            anchors.topMargin: 132
            anchors.horizontalCenter: parent.horizontalCenter
        }

        SpinBox {
            id: invoicePrice_spin
            x: 308
            width: 250
            transformOrigin: Item.Center
            Layout.minimumWidth: 150
            Layout.preferredWidth: 250;
            stepSize: 50
            prefix: "Invoice Price: "
            maximumValue: 999999999
            suffix: " (IQD)"
            anchors.top: parent.top
            anchors.topMargin: 163
            anchors.horizontalCenter: parent.horizontalCenter
        }

        SpinBox {
            id: amount_spin
            x: 195
            width: 250
            Layout.minimumWidth: 150
            Layout.preferredWidth: 250;
            suffix: qsTr(" (Item)")
            stepSize: 1
            prefix: qsTr("Amount: ")
            maximumValue: 999999999
            anchors.horizontalCenterOffset: 0
            anchors.top: parent.top
            anchors.topMargin: 194
            anchors.horizontalCenter: parent.horizontalCenter
        }

        SpinBox {
            id: bonus_spin
            x: 308
            width: 250
            Layout.minimumWidth: 150
            Layout.preferredWidth: 250;
            suffix: "(Item)"
            prefix: "Bonus Amount: "
            maximumValue: 999999999
            anchors.top: parent.top
            anchors.topMargin: 225
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
        }

        FileDialog {
            id: file_dlg
            title: "Please choose item's image on stored on your computer."
            onAccepted: {
                var imageStr = fileUrl.toString().slice(fileUrl.toString().lastIndexOf('/')+1);
                if(imageStr.length > 16) imageStr =  imageStr.substring(16) + "(Striped name)"
                imagePath_btn.text = "Image: " + imageStr;
                root.imageUrl = fileUrl;

            }
        }

        Button {
            id: imagePath_btn
            x: 195
            width: 250
            Layout.minimumWidth: 150
            Layout.preferredWidth: 250;
            text: "Image Path ..."
            anchors.horizontalCenterOffset: 0
            tooltip: "Item's image stored in your computer"
            anchors.top: parent.top
            anchors.topMargin: 256
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: file_dlg.visible = true
        }

        Label {
            id: expiry_lbl
            x: 302
            text: "Expiry Date"
            font.family: "Arial"
            anchors.top: parent.top
            anchors.topMargin: 289
            anchors.horizontalCenter: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.minimumWidth: 150
            Layout.preferredWidth: 250;

            RowLayout {
                id: expiry_lay
                property alias year: year_combo.currentIndex
                property alias month: month_combo.currentIndex
                property alias year_model: year_combo.model
                property alias month_model: month_combo.model

                x: 195
                width: 250
                height: 25
                Layout.minimumWidth: 150
                Layout.preferredWidth: 250;
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 4
                ComboBox {
                    id: year_combo
                    Layout.minimumWidth: 60
                    Layout.preferredWidth: 123
                    model: {

                        var y = new Date().getFullYear();
                        var lst = [];
                        for(var i = y; i < y + 10; i++) {
                            lst.push(i)
                        }
                        model = lst;

                    }
                }

                ComboBox {
                    id: month_combo
                    Layout.minimumWidth: 60
                    Layout.preferredWidth: 123
                    currentIndex: {
                        var m = new Date().getMonth();
                        month_box.currentIndex = m;
                    }
                    model: ['January', 'Febuary', 'March', 'April', 'May', 'June', 'July', 'August', 'September',
                           'October', 'November', 'December']
                }
            }
        }

        Button {
            id: place_btn
            x: 278
            text: "Place ..."
            Layout.minimumWidth: 150
            Layout.preferredWidth: 250;
            anchors.top: parent.top
            anchors.topMargin: 350
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                place_frm = Qt.createComponent("PlaceForm.qml").createObject(root.parent, {});
                place_frm.accepted.connect(setPlace);
            }
        }

        Label {
            id: discription_lbl
            x: 195
            y: 383
            text: "Discription"
            anchors.horizontalCenterOffset: 0
            anchors.top: parent.top
            anchors.topMargin: 383
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Arial"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.minimumWidth: 150
            Layout.preferredWidth: 250
            TextArea {
                id: discription_area
                x: 169
                Layout.minimumWidth: 150
                Layout.preferredWidth: 250
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Arial"
                tabChangesFocus: true

            }
        }

        Button {
            id: add_btn
            x: 277
            width: 250
            height: 25
            text: "Add"
            anchors.top: parent.top
            anchors.topMargin: 559
            anchors.horizontalCenterOffset: 0
            Layout.minimumWidth: 150
            Layout.preferredWidth: 250
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                var expiryDate = new Date()
                var expiryYear = year_combo.model[year_combo.currentIndex];
                var expiryMonth = month_combo.currentIndex + 1
                var expiryDay = 1

                expiryDate.setFullYear(expiryYear);
                expiryDate.setMonth(expiryMonth);
                expiryDate.setDate(expiryDay);

                var tags = root.tags.split(',');
                tags.forEach(function(tag) {
                    tag = tag.trim();
                });
                console.debug("PLACE", placeUrl);
                PharmData.insertItem(root.barcode, root.name, root.scientificName, root.discription, root.imageUrl, root.sellingPrice, root.invoicePrice, root.amount, root.bonus, expiryDate, placeUrl, root.posX, root.posY, tags);
                successBox.visible = true;
                Script.reset();
            }
        }

        MBox {
            id: successBox
            titleText: "Item successfully added."
            contentText: "Your item has been successfully added to the database"
            buttonState: "OK"
            boxHeight: 200
            boxWidth: 400
        }

        PharmItem {
            id: item;
            barcode: root.barcode
            name: root.name
            scientificName: root.scientificName
            discription: root.discription
            sellingPrice: root.sellingPrice
            invoicePrice: root.invoicePrice
            amount: root.amount
            bonus: root.bonus
            imagePath: root.imageUrl
            placePath: root.placeUrl
            posX: root.posX
            posY: root.posY
            tags: root.tags
        }
    }
}
