import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    visible: true
    width: 1400
    height: 715

    title: qsTr("SEGSLauncher")
    // flags: Qt.FramelessWindowHint | Qt.WindowMinimizeButtonHint | Qt.Window

    // Load custom fonts

    FontLoader { id: cuppaJo; source: "qrc:/Resources/Fonts/cuppajoe.ttf" }
    FontLoader { id: cantarell_regular; source: "qrc:/Resources/Fonts/Cantarell-Regular.ttf" }

    Loader {
        id: mainWindowLoader
        active: true
        source: "MainWindow2.qml"
//        asynchronous: true
        visible: true
//        onLoaded: {
//            item.visible = true;
//        }
    }

}

