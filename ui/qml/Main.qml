import QtQuick 2.15
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.13
import QtQuick.Controls.Material 2.12

ApplicationWindow {
    id: applicationWindow
    // Theme
    Material.theme: Material.Light
    Material.primary: Material.Red
    Material.accent: Material.Orange
    Material.foreground: '#000000'
    Material.background: Material.LightGrey


    width: 1280
    height: 960
    visible: true
    visibility: "Windowed"
    minimumHeight: 960
    minimumWidth: 1280

    function onScreenChange() {
        console.log('onScreenChange');
        var cur = MainViewModel.current_page();
        currentPage = pageList[cur];
    }

    function onCompleteSendMesssage() {
        console.log('onCompleteSendMesssage');
        var cur = MainViewModel.current_page();
        currentPage = pageList[cur];
    }

    ToolBar {
        id: toolBar
        y: 0
        z: 1
        height: 40
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        Layout.fillWidth: true
        RowLayout {
            anchors.fill: parent

            Label {
                text: "郵便物通知システム"
                color: '#ffffff'
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

        }
    }

    Component.onCompleted: {
        console.log('Component.onCompleted')
        MainViewModel.screenChanged.connect(onScreenChange);
        MainViewModel.onCompleteSendMessage.connect(onCompleteSendMesssage);
    }

    property string  currentPage : "CameraPage";

    property variant pageList  : [
        "CameraPage",
        "ResultPage",
        "MembersPage"
    ];

    Component {
        id: mainView
        CameraPage {}
    }

    Component {
        id: resultView
        ResultPage {}
    }

    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.rightMargin: 0
        anchors.right: parent.right
    }

    Repeater {
        model: pageList;
        delegate: Loader {
            active: false;
            asynchronous: true;
            anchors.fill: parent;
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: (currentPage === modelData);
            source: "%1.qml".arg(modelData)
            onVisibleChanged:      { loadIfNotLoaded(); }
            Component.onCompleted: { loadIfNotLoaded(); }

            function loadIfNotLoaded () {
                // to load the file at first show
                if (visible && !active) {
                    active = true;
                }
            }
        }
    }

    onWindowStateChanged: {
        console.log( "onWindowStateChanged (Window), state: " + windowState );
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.33}D{i:1}
}
##^##*/
