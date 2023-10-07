/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: rectangle
    width: 1400
    height: 715

    Image {
        id: button_play
        x: 1230
        y: 644
        source: "Resources/Images/button_play.png"
        fillMode: Image.PreserveAspectFit

        Text {
            id: button_play_text
            x: 37
            y: 10
            width: 111
            height: 22
            color: "#ffffff"
            text: qsTr("LAUNCH")
            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter
            font.family: "CuppaJoe"
        }

        MouseArea {
            id: button_play_mouseArea
            anchors.fill: parent
            anchors.leftMargin: 31

            Connections {
                target: button_play_mouseArea
                onClicked: Qt.quit()
            }
        }
    }

    Image {
        id: button_settings
        x: 1069
        y: 637
        width: 190
        height: 56
        source: "Resources/Images/button_settings.png"
        fillMode: Image.PreserveAspectFit

        Text {
            id: button_settings_text
            x: 40
            y: 17
            width: 111
            height: 22
            color: "#ffffff"
            text: qsTr("SETTINGS")
            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter
            font.family: "CuppaJoe"
        }

        MouseArea {
            id: button_settings_mouseArea
            anchors.fill: parent
            anchors.leftMargin: 31
            anchors.rightMargin: 27
        }
    }
}
