import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.13
import QtQml.Models 2.15

Rectangle {
    id: item1
    anchors.topMargin: 56
    anchors.fill: parent

    ColumnLayout {
        anchors {
            horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: message1
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
            text: qsTr("宛先は")
            font.pointSize: 48
        }

        Text {
            id: destination
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignCenter
            text: ResultViewModel.get_to_name()
            font.pointSize: 48
        }

        Text {
            id: message3
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignCenter
            text: qsTr("でよろしいですか？")
            font.pointSize: 48
        }

        RowLayout {
            id: rowLayout
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            spacing: 32

            Button {
                id: negativeButton
                text: qsTr("手動で選択")
                font.pointSize: 48
                Material.foreground: '#ffffff'

                onClicked: {
                    MainViewModel.on_cancel_send_message();
                }
            }

            Button {
                id: positiveButton
                text: qsTr("送信")
                font.pointSize: 48
                Material.foreground: '#ffffff'
                Material.background: Material.accentColor

                onClicked: {
                    ResultViewModel.on_click_positive_button();
                }
            }
        }
    }

    property variant pageList  : [
        SendMessageView
    ];

    Component.onCompleted: {
        console.log('onCompleted');
        var result = ResultViewModel.get_to_name();
        destination.text = result;

        ResultViewModel.didSendMessage.connect(onCompletedSendMessage);
        MainViewModel.screenChanged.connect(onScreenChange);
    }

    function onCompletedSendMessage() {
        MainViewModel.on_complete_send_message();
    }

    function onScreenChange() {
        destination.text = ResultViewModel.get_to_name();
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.75;height:480;width:640}
}
##^##*/
