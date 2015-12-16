// This QML file (called Dialog.qml) is used to create a simple popup
// It will show an overlay on top of the parent and a small white area
// that is the dialog itself. For demo purposes no fancy stuff in the popup
import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import PharmAcS.DataEngine 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Controls.Styles 1.0
import "storage.js" as Storage

// Use an item as container to group both the overlay and the dialog
// I do this because the overlay itself has an opacity set, and otherwise
// also the dialog would have been semi-transparent.
// I use an Item instead of an Rectangle. Always use an 'Item' if it does not
// display stuff itself, this is better performance wise.
Item {
    id: dialogComponent
    anchors.fill: parent

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
        property url placePath;
        property int tileWidth: 80
    //    signal placePathChanged();
        id: root
        height: 80
        width: 200;
        Component.onCompleted: {
            console.log("width: ", width);
        }


        RowLayout {
            id: lay
    //        property alias row_lay: flick.row_lay
            property alias placePath: root.placePath;

            anchors.fill: parent

            function showFD() {
                flick.showFD();
            }

            function select(index) {
                flick.selected = index
                flick.selectedRect.parent = flick.img_lst[flick.selected];
                lay.placePath = flick.img_lst[flick.selected].source
                console.log("placePath: ", lay.placePath);
    //            if(flick.img_lst[flick.selected].x+flick.img_lst[flick.selected].w < flick.width) flick.flickableItem.contentX = flick.img_lst[flick.selected].x;
            }

    //        ScrollViewStyle {
    //            id: ss
    ////            control: Item{}
    //        }

            ScrollView {
                id: flick
                style: ScrollViewStyle {
                    incrementControl: null
                    decrementControl: null
                    handle: null
                    corner: null
                    frame: null
                    scrollBarBackground: null
                }

                function showFD() {
                    row_lay.showFD();
                }

                property alias img_lst: row_lay.img_lst
                property alias pathList: row_lay.pathList
                property alias selectedRect: row_lay.selectedRect
                property alias selected: row_lay.selected
                property alias placePath: lay.placePath
                x: row_lay.x
                width: 10
                height: 90 //??? 80
                anchors.right: right_btn.left
                anchors.rightMargin: 8
                anchors.left: left_btn.right
                anchors.leftMargin: 8
                anchors.top: parent.top
                anchors.topMargin: 8
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8

                flickableItem.contentHeight: height + 10
                flickableItem.contentWidth: (PharmData.placesPaths.length+1)*60 + PharmData.placesPaths.lenght*4

                Row {
                    id: row_lay
                    property var img_lst: []
                    property var pathList: PharmData.placesPaths
                    property var selectedRect
                    property int selected: 0
                    property int pathToDeleteIndex: 0
    //                property var addButton;
                    property alias placePath: lay.placePath
                    anchors.fill: parent
                    property alias row_width: row_lay.width
                    property alias row_height: row_lay.height
                    property var unexistingPaths: []
                    spacing: 4


                    FileDialog {
                        id: fd
                        selectMultiple: true
                        nameFilters: [ "Image files (*.jpg *.png)", "All files (*)" ]
                        title: "Please choose the file of the path's image"
                        onAccepted: {
                            fd.fileUrls.forEach(function(path) {
                                PharmData.addPlacePath(path);
                            });
                            row_lay.loadEverything();
                        }
                    }

                    function showFD() {
                        fd.visible = true;
                    }

                    MBox {
                        parent: root.parent
                        id: dp_dlg
                        titleText: "Are you sure?"
                        boxWidth: root.parent.width/3
                        boxHeight: root.parent.height/3
                        buttonState: "YESNO"
                        onYes: {
                            PharmData.deletePlacePath(row_lay.img_lst[row_lay.pathToDeleteIndex].source);
                            row_lay.loadEverything();
                            console.log("hello");
                        }
                    }

                    function deletePath(i) {
                        dp_dlg.contentText = "Are you sure you want to delete\n" + flick.img_lst[i].source.toString() + "\nfrom your path list?";
                        pathToDeleteIndex = i;
                        dp_dlg.visible = true
                    }

                    MBox {
                        parent: root.parent
                        id: nf_dlg
                        titleText: "Incorrect Place Path";
                        boxWidth: root.parent.width/3
                        boxHeight: root.parent.height/5
                        buttonState: "YESNO"
    //                    contentText: "These paths do not eixst anymore: " + row_lay.unexistingPaths.toString() // to be set un unexistingPaths is populated
                        onYes: {
                            row_lay.unexistingPaths.forEach(function(path) {
                                PharmData.deletePlacePath(path);
                            });
                        }
                        Component.onCompleted: {

                        }
                    }

                    function loadEverything() {
                        PharmData.loadPlacesPaths();
                        while(img_lst.length !== 0){
    //                        addButton.visible = false;
    //                        addButton.destroy();
                            img_lst[img_lst.length-1].visible = false;
                            img_lst[img_lst.length-1].destroy();

                            img_lst.pop(img_lst.length);
                            console.debug("debug image lenght::::::::::::::::::",img_lst.length)
                        }

    //                    Storage.initialize();
    //                    selected = Storage.getSetting('lastPlaceSelected');
                        selected = 0;
                        console.log("selected: ", selected);
                        var emptyPathList  = pathList.length === 0
                        if(!emptyPathList) {
                        var PathsNotFound = false;
                        pathList.forEach(function(path) {
                            if(PharmData.fileExists(path)) {
                                var img = Qt.createQmlObject("import QtQuick 2.0; Image{width: " + root.tileWidth +"; height: parent.height; smooth: true; fillMode: Image.Stretch ; }", row_lay, "file.txt");
                                img.source = path;
                                img_lst.push(img);
                                console.log("img_lst.push:", img_lst);
                                console.log(path);
                            } else {
                                console.debug("______________________pathsnotfound___________________________");
                                unexistingPaths.push(path);
                                console.debug("unexistingPaths: ", unexistingPaths);
                                PathsNotFound = true;
                            }
                        });
                            if(PathsNotFound){
    //                            console.debug("______________________pathsnotfound___________________________");
                                nf_dlg.contentText = "These place paths have not been found:  \n" + unexistingPaths + "\nDo you want to delete them?"
                                nf_dlg.visible = true;
                                console.debug(nf_dlg.visible);
                            }
                        }
                        if(selected > img_lst.length) selected = 0;
                        console.log("img_list[selected]: ", img_lst[selected]);
                        console.log("img_lst: ", img_lst);
                        console.log("selected2: ", selected)
                        if(img_lst.length !== 0) {
                            console.log("pathList: ", pathList);
                            row_lay.placePath = img_lst[selected].source;
                            selectedRect = Qt.createQmlObject("import QtQuick 2.0; Rectangle{anchors.fill: parent; color: 'blue'; opacity: 0.5}", img_lst[selected], "error");
                       }
                        var btnMap = {}
                        for(var i = 0; i < img_lst.length; i++) {
                            btnMap[i] = Qt.createQmlObject("import QtQuick 2.0; import QtQuick.Controls 1.0; Button {text: 'x'; anchors.right: parent.right; anchors.rightMargin: 4; anchors.top: parent.top; anchors.topMargin: 4; width: 10; height: 10; onClicked: row_lay.deletePath(" + i  + ")}", img_lst[i]);
                        }
                    }

                    Component.onCompleted: {
                        loadEverything();
                        console.log("row_lay Width:", row_lay.width)
    //                    flick.width = 200;
                        console.log("flick width:", flick.width);
    //                    Storage.initialize();
    //                    selected = Storage.getSetting('lastPlaceSelected');
    //                    console.log("selected: ", selected);
    //                    var emptyPathList  = pathList.length === 0
    //                    if(!emptyPathList) {
    //                    pathList.forEach(function(path) {
    //                        if(PharmData.fileExists(path)) {
    //                            var img = Qt.createQmlObject("import QtQuick 2.0; Image{width: " + root.tileWidth +"; height: parent.height; smooth: true; fillMode: Image.Stretch ; }", row_lay, "file.txt");
    //                            img.source = path;
    //                            img_lst.push(img);
    //                            console.log("img_lst.push:", img_lst);
    //                            console.log(path);
    //                        } else {
    //                            console.log("file not found");
    //                        }
    //                    });
    //                    }
    //                    if(selected > img_lst.length) selected = 0;
    //                    console.log("img_list[selected]: ", img_lst[selected]);
    //                    console.log("img_lst: ", img_lst);
    //                    console.log("selected2: ", selected)
    //                    if(img_lst.length !== 0) {
    //                        console.log("pathList: ", pathList);
    //                        row_lay.placePath = img_lst[selected].source;
    //                        selectedRect = Qt.createQmlObject("import QtQuick 2.0; Rectangle{anchors.fill: parent; color: 'blue'; opacity: 0.5}", img_lst[selected], "error");
    //                    }
    //                    var addButton = Qt.createQmlObject("import QtQuick 2.0; import QtQuick.Controls 1.0; Button{width: 80; height: parent.height; text: \"Add Place\"; onClicked: parent.showFD();}", row_lay, "add_btn_err")
                    }

    //                Button {
    //                    width: root.tileWidth
    //                    height: parent.height
    //                    text: "Add Place"
    //                }
                }

            }

            Button{
                id: addPlace_btn
                width: 80

                height: parent.height;
                text: "Add Place";
                onClicked: lay.showFD();
                anchors.left: parent.left
                anchors.leftMargin: parent.width-88
                anchors.top: parent.top
                anchors.topMargin: 8
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                anchors.right: parent.right
                anchors.rightMargin: 8
            }

            Button {
                id: right_btn
                text: ">"
                opacity: 0.7
                width: 20
                anchors.left: parent.left
                anchors.leftMargin: parent.width -116
                anchors.top: parent.top
                anchors.topMargin: 8
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                anchors.right: addPlace_btn.left
                anchors.rightMargin: 8
                onClicked: {
                    if(flick.selected < flick.img_lst.length-1){
                        lay.select(flick.selected + 1);
                        if((flick.img_lst[flick.selected].x + flick.img_lst[flick.selected].width) >= flick.width)
    //                        flick.flickableItem.contentX += (flick.img_lst[flick.selected].width + row_lay.spacing);
                            rightanime.start();
    //                    if (flick.width > (flick.img_lst[flick.selected].x + flick.img_lst[flick.selected].width))
    //                        flick.flickableItem.contentX += flick.img_lst[flick.selected].width;
                    } else {
                        lay.select(0);
    //                    flick.flickableItem.contentX = 0;
                        right0Anime.start();
                    }
                }

                NumberAnimation {
                    id: rightanime
                    target: flick.flickableItem
                    properties: "contentX"
                    from: flick.flickableItem.contentX
                    to: flick.flickableItem.contentX + flick.img_lst[flick.selected].width + row_lay.spacing;
                    easing: {type: Easing.Linear; duration: 75}
                }

                NumberAnimation {
                    id: right0Anime
                    target: flick.flickableItem
                    properties: "contentX"
                    from: flick.flickableItem.contentX
                    to: 0
                    easing: {type: Easing.Linear; duration: 75}
                }

            }



            Button {
                id: left_btn
                text: "<"
                opacity: 0.7
                width: 20
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.right: parent.right
                anchors.rightMargin: parent.width-28
                anchors.top: parent.top
                anchors.topMargin: 8
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                onClicked: {
                     if(flick.selected > 0){
    //                     flick.selected -= 1;
    //                     flick.selectedRect.parent = flick.img_lst[flick.selected];
    //                     lay.placePath = flick.img_lst[flick.selected].source.toString().substring(7);
    //                     console.log("placePath: ", lay.placePath);
    //                     //placePathChanged();
                         lay.select(flick.selected-1);
                         if(flick.flickableItem.contentX > flick.img_lst[flick.selected].x)
    //                        flick.flickableItem.contentX = flick.img_lst[flick.selected].x
                             leftAnime.start();

                     } else {
                         lay.select(flick.img_lst.length-1);
    //                     flick.flickableItem.contentX = flick.img_lst[flick.selected].x + flick.img_lst[flick.selected].width - flick.width
                         leftEndAnime.start();


    //                     flick.flickableItem.contentX = row_lay.img_lst[row_lay.selected].x
                     }

                }

                NumberAnimation {
                    id: leftAnime
                    target: flick.flickableItem
                    properties: "contentX"
                    from: flick.flickableItem.contentX
                    to: flick.img_lst[flick.selected].x
                    easing: {type: Easing.Linear; duration: 75}
                }

                NumberAnimation {
                    id: leftEndAnime
                    target: flick.flickableItem
                    properties: "contentX"
                    from: flick.flickableItem.contentX
                    to: flick.img_lst[flick.selected].x + flick.img_lst[flick.selected].width - flick.width
                    easing: {type: Easing.Linear; duration: 75}
                }
            }


        }
    //    Component.onDestruction: {
    //        Storage.initialize();
    //        Storage.setSetting("selected", flick.selected);
    //    }
    }

}
