import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.13
import QtQml.Models 2.15
import CameraView 1.0

Rectangle {
    id: mainViewComponent
    anchors.fill: parent

    CameraView {
        id: cameraView
        width: 1280
        height: 720
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
    }

    Button {
        id: button
        anchors {
            top: cameraView.bottom
            bottom: parent.bottom
            rightMargin: 8
            leftMargin: 8
            left: parent.left
            right: parent.right
        }
        Layout.fillWidth: true
        Layout.fillHeight: true
        height: 64

        text: qsTr("宛先を抽出")
        font.pixelSize: 32

        Material.foreground: '#ffffff'
        Material.background: Material.accentColor

        onClicked: {
            startOCR();
        }
    }

    Timer {
        interval: 1000 / 30
        repeat: true
        running: true
        onTriggered: {
            cameraView.update();
        }
    }

    Component.onCompleted: {
        console.log("CameraPage::onCompleted");
        MainViewModel.onChangedVisibleStateCameraPage.connect(onChangedVisibleState);
    }

    function startOCR() {
        const filename = cameraView.save_image();
        const result = CameraViewModel.start_ocr(filename);
        console.log(result);
        ResultViewModel.set_result(result);
        MainViewModel.on_complete_ocr();
    }

    function onChangedVisibleState(is_visible) {
        cameraView.on_changed_visible_state(is_visible);
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
