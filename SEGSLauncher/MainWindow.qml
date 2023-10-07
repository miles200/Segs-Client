import QtQml 2.15
import QtQuick 2.10
import QtQuick.Window 2.2
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtMultimedia 5.15

import segs.launchersetup 1.0
import segs.launcher 1.0
import segs.worker 1.0

import "launcher.js" as Launcher

Window {

    id: root
    objectName: "mainWindow"
    visible: true
    width: 1400
    height: 715
    color: "#00000000"
    title: qsTr("SEGSLauncher")
    flags: Qt.FramelessWindowHint | Qt.WindowMinimizeButtonHint | Qt.Window

    MediaManager { id: media_manager; visible: false }

    // Set ID's for backend functions
    LauncherSetup { id: backend_launcher_setup }
    Launcher { id: backend_launcher }

    // Load custom fonts

    FontLoader { id: cuppaJo; source: "qrc:/Resources/Fonts/cuppajoe.ttf" }
    FontLoader { id: cantarell_regular; source: "qrc:/Resources/Fonts/Cantarell-Regular.ttf" }

    // Color variables
    property color hoverColor: "#999999"
    property color pressColor: "#999999"
    property color textColor: "#666666"
    property color backgroundColor: "#0f7aff"
    property color textColorBlue: "#0f7aff"
    property color gettingStatusColor: "blue"
    property color onlineColor: "green"
    property color offlineColor: "#999999"

    // Other variables
    property bool comboBox_server_select_italic: false
    property string server_info_text: ""



    MainWindowForm {

        MouseArea {
            hoverEnabled: true
            anchors.fill: button_close
            onEntered: {
                button_close.state = 'Hovering'
            }
            onExited: {
                button_close.state = ''
            }
            onClicked: {
                Qt.quit()
            }
            onReleased: {
                if (containsMouse)
                    button_close.state = "Hovering"
                else
                    button_close.state = ""
            }
        }

        states: [
            State {
                name: "Hovering"
                PropertyChanges {
                    target: button_close
                    color: hoverColor
                }
                PropertyChanges {
                    target: label_button_close
                    color: textColor
                }
            }
        ]

        Loader {
            id: setupScreenLoader
            width: 0
            height: 0
            visible: true
            active: false
            source: "qrc:/Setup.qml"
            onLoaded: {
                item.visible = true
            }
        }



    }

    // When main window loaded, call these functions.
    Component.onCompleted: {
        media_manager.startup_audio.play()
        Launcher.start_up()

    }




}
