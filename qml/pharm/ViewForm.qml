import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import PharmAcS.DataEngine 1.0
import PharmItem 1.0

import "viewForm_script.js" as Script

Rectangle {
    id: root
    color: "white"
    LayoutMirroring.enabled: false;
    LayoutMirroring.childrenInherit: true

    // the item specified for viewing
    property var pharmItem: null



    onPharmItemChanged: Script.showItemInfo()

    Rectangle {
        id: placeViewContainer
        parent: root.parent
        anchors.fill: parent
        visible: false

        onVisibleChanged: {
            if(visible) {
                placeViewImage.source = "image://pharmimages/rec(" + pharmItem.posX + ", " + pharmItem.posY + ")/" + pharmItem.placePath
            }
        }

        MouseArea {
            id: ma
            anchors.fill: parent
        }

        Rectangle {
            id: placeViewShading
            opacity: 0.4
            color: "darkgrey"
            anchors.fill: parent
        }

        Rectangle {
            id: closePlaceViewBtn
            anchors.bottom: placeView.top
            anchors.right: placeView.right
            color: "red"
//            radius:s 8
            width: txt_btn.width + 10
            height: txt_btn.height + 10
            z: 3
            Text {
                id: txt_btn
                anchors.centerIn: parent
                color: "white"
                text: "Close [x]"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: placeViewContainer.visible = false;
            }
        }

        Rectangle {
            id: placeView



            anchors {
                right: parent.right
                rightMargin: 100
                left: parent.left
                leftMargin: 100
                top: parent.top
                topMargin: 100
                bottom: parent.bottom
                bottomMargin: 100
            }
            ScrollView {
                id: placeScroll
                anchors.fill: parent;
                Image {
                    id: placeViewImage
//                    anchors.fill: parent
                }
            }
        }
    }


    ScrollView {
        id: sv
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.lef
        anchors.horizontalCenter: parent.horizontalCenter


        ColumnLayout {
            id: lay
            spacing: 4

            GroupBox {
                id: infoGroup
                title: "Information displayed";
//                anchors.top: parent.top
//                anchors.topMargin: 8
//                anchors.right: parent.right
//                anchors.rightMargin: 8
//                anchors.left: parent.left
//                anchors.leftMargin: 8
                implicitWidth: parent.width-8

                CheckBox {
                    id: barcode_check
                    text: "Barcode"
                    onCheckedChanged: {
                        if(!checked) barcode_lbl.text = ""
                    }

                }

                CheckBox {
                    id: name_check
                    text: "Name"
                    anchors {
                        top: barcode_check.bottom
                        topMargin: 4
                    }
                    onCheckedChanged: {
                        if(!checked) name_lbl.text = ""
                    }
                }

                CheckBox {
                    id: scientificName_check
                    text: "Scientific name"
                    anchors {
                        top: name_check.bottom
                        topMargin: 4;
                    }
                    onCheckedChanged: {
                        if(!checked) scientificName_lbl.text = ""
                    }
                }

                CheckBox {
                    id: tags_check
                    text: "Tags"
                    anchors {
                        top: scientificName_check.bottom
                        topMargin: 4;
                    }
                    onCheckedChanged: {
                        if(!checked) tags_lbl.text = ""
                    }
                }

                CheckBox {
                    id: sellingPrice_check
                    text: "Selling Price"
                    anchors {
                        top: tags_check.bottom
                        topMargin: 4;
                    }
                    onCheckedChanged: {
                        if(!checked) sellingPrice_lbl.text = ""
                    }
                }

                CheckBox {
                    id: invoicePrice_check
                    text: "Invoice Price"
                    anchors {
                        top: sellingPrice_check.bottom
                        topMargin: 4;
                    }
                    onCheckedChanged: {
                        if(!checked) invoicePrice_lbl.text = ""
                    }
                }

                CheckBox {
                    id: amount_check
                    text: "Amount"
                    anchors {
                        top: invoicePrice_check.bottom
                        topMargin: 4
                    }
                    onCheckedChanged:  {
                        if(!checked) amount_lbl.text = ""
                    }
                }

                CheckBox {
                    id: bonus_check
                    text: "Bonus"
                    anchors {
                        top: amount_check.bottom
                        topMargin: 4
                    }
                    onCheckedChanged: {
                        if(!checked) bonus_lbl.text = ""
                    }
                }

                CheckBox {
                    id: expiry_check
                    text: "Expiry Date"
                    anchors {
                        top: bonus_check.bottom
                        topMargin: 4
                    }
                    onCheckedChanged: {
                        if(!checked) expiry_lbl.text = ""
                    }
                }

                CheckBox {
                    id: place_check
                    text: "Place"
                    anchors {
                        top: expiry_check.bottom
                        topMargin: 4
                    }
                    onCheckedChanged: {
                        if(!checked) viewPlace_btn.visible = false
                    }
                }

                CheckBox {
                    id: image_check
                    text: "Item image"
                    anchors {
                        top: place_check.bottom
                        topMargin: 4
                    }
                    onCheckedChanged: {
                        if(!checked) {
                            //item_img.source = null;
                            item_img.visible = false;
                        }
                    }
                }

                CheckBox {
                    id: discription_check
                    text: "Discription"
                    anchors {
                        top: image_check.bottom
                        topMargin: 4
                    }
                    onCheckedChanged: {
                        if(!checked) {
                            discription_lbl.text = ""
                        }
                    }
                }

                Row {
                    id: selectionButtons_row
                    anchors {
                        top: discription_check.bottom
                        topMargin: 4
                        right: parent.right
                        rightMargin: 8
                        left: parent.left
                        leftMargin: 4
                    }

                    Button {
                        id: selectAll_btn
                        text: "Select All"
                        onClicked: Script.selectAllChecks()
                    }

                    Button {
                        id: deselectAll_btn
                        text: "Deselect All"
                        onClicked: Script.deselectAllChecks()
                    }
                }

                Component.onCompleted: Script.selectAllChecks();
            }


            GroupBox {
                id: detailsGroup
                title: "Details"
//                anchors.top: infoGroup.bottom
//                anchors.topMargin: 8
//                anchors.right: parent.right
//                anchors.rightMargin: 8
//                anchors.left: parent.left
//                anchors.leftMargin: 8
                implicitWidth: parent.width-8
                Label {
                    // BARCODE  label
                    id: barcode_lbl
                    width: 250
                    Layout.minimumWidth: 150
                    Layout.preferredWidth: 250

                }

                Label {
                    // NAME label
                    id: name_lbl
                    width: 250
                    Layout.minimumWidth: 150
                    Layout.preferredWidth: 250
                    anchors {
                        top: barcode_lbl.bottom
                        topMargin: 4
                    }
                }

                Label {
                    // SCIENTIFIC NAME label
                    id: scientificName_lbl
                    width: 250
                    Layout.minimumWidth: 150
                    Layout.preferredWidth: 250
                    anchors {
                        top: name_lbl.bottom
                        topMargin: 4
                    }
                }

                Label {
                    // TAGS label
                    id: tags_lbl
                    width: 250
                    Layout.minimumWidth: 150
                    Layout.preferredWidth: 250
                    anchors {
                        top: scientificName_lbl.bottom
                        topMargin: 4
                    }
                }




                Label {
                    // SELLING PRICE label
                    id: sellingPrice_lbl
                    width: 250
                    Layout.minimumWidth: 150
                    Layout.preferredWidth: 250
                    anchors {
                        top: tags_lbl.bottom
                        topMargin: 4
                    }
                }

                Label {
                    // INVOICE PRICE label
                    id: invoicePrice_lbl
                    width: 250
                    Layout.minimumWidth: 150
                    Layout.preferredWidth: 250
                    anchors {
                        top: sellingPrice_lbl.bottom
                        topMargin: 4
                    }
                }

                Label {
                    // AMOUNT LABEL
                    id: amount_lbl
                    width: 250
                    Layout.minimumWidth: 150
                    Layout.preferredWidth: 250
                    anchors {
                        top: invoicePrice_lbl.bottom
                        topMargin: 4
                    }
                }

                Label {
                    // BONUS LABEL
                    id: bonus_lbl
                    width: 250
                    Layout.minimumWidth: 150
                    Layout.preferredWidth: 250
                    anchors {
                        top: amount_lbl.bottom
                        topMargin: 4
                    }
                }

                Label {
                    id: expiry_lbl
                    width: 250
                    Layout.minimumWidth: 150
                    Layout.preferredWidth: 250
                    anchors {
                        top: bonus_lbl.bottom
                        topMargin: 4
                    }
                }

                Button {
                    id: viewPlace_btn
                    width: 250
                    text: "View place"
                    Layout.minimumWidth: 150
                    Layout.preferredWidth: 250
                    visible: false;
                    anchors {
                        top: expiry_lbl.bottom
                        topMargin: 4
                    }

                    onClicked: placeViewContainer.visible = true;
                }

                Image {
                    // ITEM IMAGE
                    id: item_img
                    width: 250
                    height: 250
                    Layout.minimumWidth: 150
                    Layout.minimumHeight: 150
                    Layout.preferredWidth: 250
                    Layout.preferredHeight: 250
                    visible: false

                    anchors {
                        top: viewPlace_btn.bottom
                        topMargin: 4
                    }
                }

                Label {
                    // DISCRIPTION LABEL
                    id: discription_lbl
                    width: 250
                    Layout.minimumWidth: 150
                    Layout.preferredWidth: 250
                    anchors {
                        top: item_img.bottom
                        topMargin: 4
                    }
                }
            }

            GroupBox {
                id: actionGroup
                title: "Actions"
                implicitWidth: parent.width-8
                Button {
                    id: delBtn
                    onClicked: Script.deleteItem();
                    text: "Delete"
                }
            }
        }
    }
}
