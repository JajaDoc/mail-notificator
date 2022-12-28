import QtQuick 2.15
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.13
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12

Rectangle {
    anchors.topMargin: 56
    anchors.fill: parent

    property variant  bookmarks : [];

    ListView {
        id: bookmarksListView
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            leftMargin: 32
            rightMargin: 32
        }
        orientation: ListView.Horizontal

        height: 75

        model: ListModel {
            id: bookmarkModel
        }

        delegate: Item {
            required property string kana
            required property string position

            width: 75
            height: 75

            Button {
                id: bookmarkButton
                text: kana
                Material.foreground: '#ffffff'
                Material.background: Material.accentColor
                font.pixelSize: 28
                onClicked: {membersListView.positionViewAtIndex(position, ListView.Beginning)}
            }
        }
    }

    Button {
        id: cancelButton
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        Layout.fillWidth: true
        Layout.fillHeight: true
        height: 64

        text: qsTr("最初にもどる")
        font.pixelSize: 32
        Material.foreground: '#ffffff'
        Material.background: Material.accentColor

        onClicked: {
            MainViewModel.reset();
        }
    }

    ListView {
        id: membersListView
        anchors {
            top: bookmarksListView.bottom
            bottom: cancelButton.top
            left: parent.left
            right: parent.right
            topMargin: 32
            bottomMargin: 64 + 8
        }

        ScrollBar.vertical: ScrollBar {
            active: true
        }
        model: ListModel {
            id: model
        }

        delegate: Item {
            required property string identifier
            required property string name
            required property string kana
            required property string address

            width: parent.width
            height: 75

            ScrollBar.vertical: ScrollBar { visible: true }

            Pane {
                property bool pressed
                id: card
                pressed: false
                anchors {
                  fill: parent
                  leftMargin: 16
                  topMargin: 16
                  rightMargin: 16
                }
                padding: 0
                Material.background: '#FFFFFF'
                Material.elevation: card.hovered ? 6 : 2

                Text {
                    id: nameText
                    anchors {
                        left: parent.left
                        top: parent.top
                        leftMargin: 8
                        topMargin: 8
                        rightMargin: 8
                    }
                    elide: Text.ElideRight
                    font.pixelSize: 28
                    font.family: "Roboto"
                    maximumLineCount: 3
                    text: name
                    wrapMode: Text.Wrap
                }

                Text {
                    id: emailText
                    color: "#888888"
                    anchors {
                        left: nameText.right
                        top: parent.top
                        right: parent.right
                        leftMargin: 8
                        topMargin: 8
                        rightMargin: 8
                    }
                    horizontalAlignment: Text.AlignRight
                    elide: Text.ElideRight
                    font.pixelSize: 24
                    font.family: "Roboto"
                    maximumLineCount: 3
                    text: address
                    wrapMode: Text.Wrap
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        card.pressed = true;
                        ResultViewModel.set_manual_result(name, address);
                        MainViewModel.on_selected_member();
                    }
                }
            }
        }

    }

    Component.onCompleted: {
        init();
    }

    function init() {
        const result = MembersViewModel.get_sorted_members();
        const members = result[0].map((member, idx) => ({
            identifier: "" + idx,
            name: member[0],
            kana: member[1],
            address: member[2]
        }));

        for (const member of members) {
            membersListView.model.append(member);
        }

        bookmarks = result[1];
        for (const p of bookmarks) {
            bookmarksListView.model.append({
                kana: result[0][p][1][0],
                position: p,
            });
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
