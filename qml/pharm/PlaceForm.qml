import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Window 2.0
//import "pharmItem.js" as Pi
import PharmItem 1.0
Item {
    id: dialogComponent
    anchors.fill: parent
    signal accepted(int posX, int posY, string placeUrl);
    signal canceled();

    // Add a simple animation to fade in the popup
    // let the opacity go from 0 to 1 in 400ms
    PropertyAnimation { target: dialogComponent; property: "opacity";
                                  duration: 400; from: 0; to: 1;
                                  easing.type: Easing.InOutQuad ; running: true }

    // This rectange is the a overlay to partially show the parent through it
    // and clicking outside of the 'dialog' popup will do 'nothing'
    Rectangle {
        anchors.fill: parent
        id: overlay
        color: "#000000"
        opacity: 0.6
        // add a mouse area so that clicks outside
        // the dialog window will not do anything
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.ArrowCursor
        }
    }

    Rectangle {

        id: root
        property bool posDefined: false

        onPosDefinedChanged: {
            ok_btn.enabled = posDefined // if position is defined enable ok_btn ...
        }

        property url placePath: places.placePath
        property alias placeViewSource: placeView.source

        width: 800
        height: 600
        anchors.centerIn: parent
        ColumnLayout {
            id: columnlayout1
            anchors.fill: parent
            spacing: 4
            ScrollView {
                id: imgScroll
                property alias posX: placeView.posX
                property alias posY: placeView.posY
                property alias placePath: root.placePath
                property alias placeViewSource: placeView.source
                //source: root.placePath

                //        height: parent.height - 100
                //        width: parent.width
                anchors.fill: parent
                //anchors.centerIn: parent
                clip: true
                //contentItem.anchors.centerIn: imgFlick
                highlightOnFocus: true
                anchors.bottomMargin: 100
                Image {
                    property int posX: -1
                    property int posY: -1
                    property alias placePath: imgScroll.placePath
                    id: placeView
                    //anchors.centerIn: parent
                    cache: false
                    source: imgScroll.placePath
//                    fillMode: Image.Stretch
                    //anchors.centerIn: parent
                    MouseArea {
                        property alias posX: placeView.posX
                        property alias posY: placeView.posY
                        property alias source: placeView.source
                        id: placeClickArea
                        anchors.fill: parent
                        cursorShape: Qt.ArrowCursor;
                        onClicked: {
                            posX = mouseX;
                            posY = mouseY;
                            console.log("(", posX, ", ", posY, ")");
                            source = "image://pharmimages/rec(" + posX + ", " + posY + ")/" + placeView.placePath;
                            console.log("placeView source: ", source);
                            root.posDefined = true;

                        }
                    }
//                    Component.onCompleted: placeClickArea.clicked.connect(root.posDefined);
                }
            }


            //    Flickable  {
            //        id: imgFlick
            //        clip: true
            //        anchors.fill: parent
            //        contentHeight: placeView.height;
            //        contentWidth: placeView.width;
            //        anchors.bottomMargin: 60
            //        Image {
            //            property int posX: 0
            //            property int posY: 0
            ////            property int orginPosX: 0
            ////            property int originPosY: 0
            //            id: placeView
            //            width: parent.width
            //            height: parent.height
            //            source: "image://pharmimages/fart.png"
            //            MouseArea {
            //                id: imageClickArea
            //                property alias posX: placeView.posX
            //                property alias posY: placeView.posY
            //                onClicked: {
            //                    posX = mouseX;
            //                    posY = mouseY;
            //                    console.log("================");
            //                    console.log("(", posX, ", ", posY, ")");
            //                }
            //            }
            //        }
            //    }
            
            
            Button {
                id: ok_btn
                text: "OK"
                enabled: false
                anchors.right: parent.right
                anchors.rightMargin: 8
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                onClicked:
                {
//                    var x = imgScroll.posX;
//                    var y = imgScroll.posY;
//                    console.log("PosX: ", x);
//                    console.log("PosY: ", y);
                    accepted(imgScroll.posX, imgScroll.posY, places.placePath.toString());
//                    console.debug("QML_DEBUG: (PLACES):", placeView.source)
                    dialogComponent.destroy();
                }
            }

            Button {
                id: cancel_btn
                text: "Cancel"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                anchors.right: ok_btn.left
                anchors.rightMargin: 6
                onClicked: dialogComponent.destroy()
            }

            PlaceManager {
                id: places
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.right: cancel_btn.left
                anchors.rightMargin: 38
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                anchors.top: imgScroll.bottom
                anchors.topMargin: 8
                onPlacePathChanged: {
                    root.placePath = places.placePath
                    placeView.source = root.placePath
                    root.posDefined = false;
//                    console.log("PLACE CHANGED FUCKER");
                }
            }

            Component.onCompleted: {
                //ok_btn.clicked.connect(dialogComponent.accepted);
                cancel_btn.clicked.connect(dialogComponent.canceled);
            }


        }
    }
}
