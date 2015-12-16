import QtQuick 2.0
import QtQuick.Controls 1.0
Item {
//    id: root
    visible: false
    id: dialogComponent
    anchors.fill: parent
    property alias titleText: titleText.text
    property alias boxWidth: box.width
    property alias boxHeight: box.height
    property alias buttonState: buttonRec.state
    property alias contentText: contentText.text

    signal ok()
    onOk: dialogComponent.visible = false;
    signal cancel()
    onCancel: dialogComponent.visible = false;
    signal yes()
    onYes: dialogComponent.visible = false;
    signal no()
    onNo: dialogComponent.visible = false;

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
        color: "black"
        opacity: 0.6
        // add a mouse area so that clicks outside
        // the dialog window will not do anything
        MouseArea {
            anchors.fill: parent
        }
    }

    // This rectangle is the actual popup
    Rectangle {
        property int minimumWidth: 180
        id: box

//        property var type: [OK, OkCancel, YesNo, YesNoCancel]
        property alias titleText: titleText.text
        anchors.centerIn: parent

        width: 100
        height: 62
        color: "white"
        Rectangle {
            id: title
            color: "#e4e4d8"
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            height: parent.height/5
            Text {
                id: titleText
                anchors.horizontalCenter: parent.horizontalCenter
                fontSizeMode: Text.Fit
            }
        }

        Rectangle {
            id: buttonRec
            color: "#e4e4d8"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            height: parent.height/5
            Button {
                id: ok_btn
                text: "OK"
                anchors.right: parent.right
                anchors.rightMargin: 8
                anchors.top: parent.top
                anchors.topMargin: 2
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                width: 50;
                onClicked: ok()
                visible: false
            }
            Button {
                id: yes_btn
                text: "Yes"
                anchors.right: parent.right
                anchors.rightMargin: 8
                anchors.top: parent.top
                anchors.topMargin: 2
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                width: 50;
                onClicked: yes()
                visible: false
            }

            Button {
                id: cancel_btn
                text: "Cancel"
                anchors.top: parent.top
                anchors.topMargin: 2
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                width: 50
                onClicked: cancel()
                visible: false
            }

            Button {
                id: no_btn
                text: "No"
                anchors.top: parent.top
                anchors.topMargin: 2
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                width: 50
                onClicked: no()
                visible: false
            }
//            state: "OKCANCEL"
            states: [
            State {
                    name: "OK"
                    PropertyChanges {
                        target: ok_btn
                        visible: true
                    }
                },

                State {
                    name: "OKCANCEL"
                    PropertyChanges {
                        target: ok_btn
                        visible: true
                    }
                    PropertyChanges {
                        target: cancel_btn
                        visible: true
                        anchors.right: ok_btn.left
                        anchors.rightMargin: 4
                    }
                },

                State {
                    name: "YESNO"
                    PropertyChanges {
                        target: yes_btn
                        visible: true
                    }
                    PropertyChanges {
                        target: no_btn
                        visible: true
                        anchors.right: yes_btn.left
                        anchors.rightMargin: 4
                    }
                },

                State {
                    name: "YESNOCANCEL"
                    PropertyChanges {
                        target: yes_btn
                        visible: true
                    }
                    PropertyChanges {
                        target: no_btn
                        visible: true
                        anchors.right: yes_btn.left
                        anchors.rightMargin: 4
                    }
                    PropertyChanges {
                        target: cancel_btn
                        visible: true
                        anchors.right: no_btn.left
                        anchors.rightMargin: 4
                    }
                }

            ]

        }

        Rectangle {
            id: contet
            color: "white"
            anchors.top: title.bottom
            anchors.topMargin: 0
            anchors.bottom: buttonRec.top
            anchors.bottomMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            ScrollView {
                anchors.fill: parent
                Text {
                    id: contentText
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    anchors.top: parent.top
                    anchors.topMargin: 8
                    fontSizeMode: Text.Fit
                }
            }
        }
        onWidthChanged: if(box.width < minimumWidth) box.width = minimumWidth

    }

        // For demo I do not put any buttons, or other fancy stuff on the popup
        // clicking the whole dialogWindow will dismiss it
}

