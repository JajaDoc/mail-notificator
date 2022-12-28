pragma Singleton
import QtQuick 2.6

QtObject {
    readonly property int SCREEN_WIDTH: 1280
    readonly property int SCREEN_HEIGHT: 960

    readonly property alias myConst: myConst_

    QtObject {
        id: myConst_
        readonly property int test: 1
        readonly property int apple: 2
        readonly property int dog: 4
    }
}
