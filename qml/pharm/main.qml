import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0
import QtQuick.Layouts 1.0

ApplicationWindow{
    id: main
    width: 1024
    height: 768


    menuBar: MenuBar {
        Menu {
            title: "&File"
            MenuItem {text: "E&xit"; onTriggered: Qt.quit(); shortcut: "Ctrl+X"}
            MenuItem {text: "Open"; onTriggered: frame.addAddForm(); shortcut: "Ctrl+O"}
        }
        Menu {
            title: "&Tools"

            MenuItem {text: "&Places Manager"; //onTriggered: pmf.visible = true
            }
        }
    }

    //anchors.margins: Qt.platform.os === "osx" ? 12 : 2
    TabView {
        id: tabView
        //        enabled: enabledCheck.checked
        tabPosition: main.item ? main.item.tabPosition : Qt.TopEdge
        anchors.fill: parent
        anchors.margins: Qt.platform.os === "osx" ? 12 : 2
//        anchors.topMargin: 40
        style: TabViewStyle {
                   property color frameColor: "#999"
                   property color fillColor: "#eee"
                   frameOverlap: 1
                   frame: Rectangle {
                       color: "#eee"
                       border.color: frameColor
                   }
                   tab: Rectangle {
                       color: styleData.selected ? fillColor : frameColor
                       implicitWidth: Math.max(text.width + 24, 80)
                       implicitHeight: 20
                       Rectangle { height: 1 ; width: parent.width ; color: frameColor}
                       Rectangle { height: parent.height ; width: 1; color: frameColor}
                       Rectangle { x: parent.width -1; height: parent.height ; width: 1; color: frameColor}
                       Text {
                           id: text
                           anchors.left: parent.left
                           anchors.verticalCenter: parent.verticalCenter
                           anchors.leftMargin: 6
                           text: styleData.title
                           color: styleData.selected ? "black" : "white"
                       }
                       Button {
                           anchors.right: parent.right
                           anchors.verticalCenter: parent.verticalCenter
                           anchors.rightMargin: 4
                           height: 16
                           style: ButtonStyle {
                               background: Rectangle {
                                   implicitWidth: 16
                                   implicitHeight: 16
                                   radius: width/2
                                   color: control.hovered ? "#eee": "#ccc"
                                   border.color: "gray"
                                   Text {text: "X" ; anchors.centerIn: parent ; color: "gray"}
                               }}
                           onClicked: {
                               tabView.removeTab(styleData.index);
                           }
                       }
                   }
               }
        function addAddForm() {
//            var component = Qt.createComponent("Tab.qml");
//            if(component.status == Component.Ready){
//                component.title = "new Add Form";
//                component.createObject(AddForm);
//            }
//            frame.addTab("new Add Form", component);
//            component.createObject()
            var cmpnt = Qt.createQmlObject('import QtQuick 2.0; import QtQuick.Controls 1.0; Tab { title: \"shitty tab\"; PlaceForm{}}', frame, "errorTab");
        }
//        PlaceManagerForm {
//             id: pmf
//            parent: frame.getTab(frame.currentIndex)
//            visible: false
//            width: frame.getTab(frame.currentIndex).width / 2
//            height: 80
//            anchors.centerIn: frame.getTab(frame.currentIndex)
//        }

        Tab {
            id: sellTab
            title: "Sell"
            SellTab{}
        }

        Tab {
            id: viewTab
            title: "View"
            ViewTab{}
        }

        Tab {
            id: addTab
            title: "Add2"
            AddForm{}
        }

    }
}
