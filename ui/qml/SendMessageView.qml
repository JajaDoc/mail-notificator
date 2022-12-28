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
            text: qsTr("宛先は")
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 48
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
        }

        Text {
            id: message2
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            text: qsTr("XXXXXXX")
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 48
            Layout.alignment: Qt.AlignCenter
        }

        Text {
            id: message3
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            text: qsTr("でよろしいですか？")
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 48
            Layout.alignment: Qt.AlignCenter
        }

        RowLayout {
            id: rowLayout
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            spacing: 32

            Button {
                id: button1
                text: qsTr("Yes")
                font.pointSize: 48

                onClicked: {
                    init();
                }
            }

            Button {
                id: button2
                text: qsTr("No")
                font.pointSize: 48

                onClicked: {
                    init();
                }
            }
        }
    }
}
