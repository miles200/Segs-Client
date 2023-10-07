import QtQuick 2.1

Rectangle {
    id: background
    x: 278
    y: 215
    width: 1100
    height: 494
    color: "#ffffff"
    visible: true
    z: 1

    AnimatedImage {
        id: loader
        x: 480
        y: 216
        visible: false
        width: 100
        height: 100
        z: 20
        smooth: true
        antialiasing: true
        clip: false
        opacity: 1
        fillMode: Image.Stretch
        playing: true
        paused: false
        source: "Resources/Icons/loader.gif"
    }

    Rectangle {
        id: button_close
        x: 1056
        y: 14
        width: 28
        height: 28
        color: backgroundColor
        radius: 2
        z: 19
        opacity: 1

        Label {
            id: label_button_close
            x: 0
            y: -1
            width: 25
            height: 32
            color: "#ffffff"
            text: qsTr("X")
            z: 1
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.italic: true
            font.bold: true
            font.family: cantarell_regular.name
            font.pointSize: 10
        }

        transitions: Transition {
            from: ""
            to: "Hovering"
            ColorAnimation {
                duration: 400
            }
        }
    }

    Rectangle {
        id: button_play
        x: 896
        y: 405
        width: 188
        height: 59
        color: "#00000000"
        opacity: 1
        rotation: 0
        visible: true
        clip: false
        z: 4

        Image {
            id: button_play_image
            anchors.rightMargin: 0
            anchors.bottomMargin: -1
            anchors.leftMargin: 0
            anchors.topMargin: 1
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: "Resources/Images/button_play.png"
        }

        Text {
            id: button_play_text
            x: 57
            y: 8
            width: 123
            height: 43
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: "white"
            text: "LAUNCH"
            z: 1
            font.bold: true
            font.pointSize: 21
            font.family: cuppaJo.name
        }

        DropShadow {
            //color: "#808080"
            anchors.fill: button_play
            horizontalOffset: 3
            verticalOffset: 3
            radius: 8.0
            samples: 10
            source: button_play_image
        }

        MouseArea {
            x: -8
            y: -6
            anchors.leftMargin: 14
            hoverEnabled: true
            anchors.fill: button_play
            onEntered: {
                button_play.state = "Hovering"
            }
            onExited: {
                button_play.state = ""
            }
            onClicked: {
                media_manager.launch_audio.play()
                backend_launcher.launch_cox()
                root.showMinimized()
            }
            onReleased: {
                if (containsMouse)
                    button_play.state = "Hovering"
                else
                    button_play.state = ""
            }
        }

        states: [
            State {
                name: "Hovering"
            }
        ]
        transitions: [
            Transition {
                from: ""
                to: "Hovering"
                PropertyAnimation {
                    target: button_play
                    properties: "scale"
                    from: 1.0
                    to: 1.1
                    duration: 200
                }
            },
            Transition {
                from: "Hovering"
                to: "*"

                PropertyAnimation {
                    target: button_play
                    properties: "scale"
                    from: 1.1
                    to: 1.0
                    duration: 200
                }
            }
        ]
    }

    Rectangle {
        id: button_settings
        x: 721
        y: 419
        width: 207
        height: 42
        color: "#00000000"
        opacity: 1
        rotation: 0
        visible: true
        clip: false
        z: 4

        Text {
            id: button_settings_text
            x: 48
            y: 0
            width: 122
            height: 39
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: "white"
            text: "SETTINGS"
            z: 1
            font.bold: true
            font.pointSize: 19
            font.family: cuppaJo.name
        }

        Image {
            id: button_settings_img
            source: "Resources/Images/button_settings.png"
            anchors.fill: parent
        }

        DropShadow {
            anchors.fill: button_settings
            horizontalOffset: 3
            verticalOffset: 3
            radius: 8.0
            samples: 10
            //color: "grey"
            source: button_settings_img
        }

        MouseArea {
            anchors.rightMargin: 17
            hoverEnabled: true
            anchors.fill: button_settings
            onEntered: {
                button_settings.state = "Hovering"
            }
            onExited: {
                button_settings.state = ""
            }
            onClicked: {
                swipeView_servinfo_settings.currentIndex = 1
            }
            onReleased: {
                if (containsMouse)
                    button_settings.state = "Hovering"
                else
                    button_settings.state = ""
            }
        }

        states: [
            State {
                name: "Hovering"
            }
        ]
        transitions: [
            Transition {
                from: ""
                to: "Hovering"
                PropertyAnimation {
                    target: button_settings
                    properties: "scale"
                    from: 1.0
                    to: 1.1
                    duration: 200
                }
            },
            Transition {
                from: "Hovering"
                to: "*"
                PropertyAnimation {
                    target: button_settings
                    properties: "scale"
                    from: 1.1
                    to: 1.0
                    duration: 200
                }
            }
        ]
    }

    // ---- Server Type SwipeView Start ----
    SwipeView {
        id: swipeView_server_select
        x: 728
        y: 288
        width: 351
        height: 111
        z: 16
        clip: true
        anchors.rightMargin: 0
        anchors.bottomMargin: 95
        anchors.leftMargin: 620
        anchors.topMargin: 221
        currentIndex: 0
        interactive: false
        visible: true
        anchors.fill: parent

        // --- Page 1 - Online Server START ---
        Item {
            id: page_community_server

            Label {
                id: label_select_server
                x: 95
                y: 22
                width: 188
                height: 22
                color: textColorBlue
                text: qsTr("SELECT SERVER")
                font.italic: false
                font.bold: true
                font.pointSize: 14
                font.family: cuppaJo.name
                horizontalAlignment: Text.AlignLeft
            }

            ComboBox {
                id: comboBox_server_select
                x: 95
                y: 50
                width: 367
                height: 55
                hoverEnabled: true
                model: ListModel {

                    id: server_list_model
                }
                background: Rectangle {
                    color: "#f1f1f1"
                    border.color: "black"
                    border.width: 1
                }
                textRole: "displayText"
                delegate: ItemDelegate {
                    id: comboBox_server_select_delegate
                    width: comboBox_server_select.width
                    height: 50

                    MouseArea {
                        z: 1
                        width: comboBox_server_select_delegate.width
                        height: comboBox_server_select_delegate.height
                        hoverEnabled: true
                        onPressed: {
                            mouse.accepted = false
                        }

                        Rectangle {
                            color: "yellow"
                            opacity: 0.65
                            visible: parent.containsMouse
                            anchors.fill: parent
                        }
                    }
                    contentItem: Row {
                        z: 2
                        Text {
                            id: comboBox_server_select_delegate_type_text
                            text: model.displayTextType
                            topPadding: 17
                            leftPadding: 23
                            clip: false
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: cantarell_regular.name
                            font.pointSize: 8
                            font.italic: comboBox_server_select_italic
                            font.bold: true
                            textFormat: Qt.RichText
                            color: "#666666"
                            elide: Text.ElideMiddle
                        }
                    }
                    Row {
                        z: 2
                        padding: 5

                        Image {
                            width: 18
                            height: 18
                            source: model.comboBox_server_select_svg
                            verticalAlignment: Image.AlignVCenter
                            horizontalAlignment: Image.AlignLeft
                        }
                        Text {
                            id: comboBox_server_select_delegate_text
                            text: model.displayText
                            leftPadding: 10
                            clip: false
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: cantarell_regular.name
                            font.pointSize: 12
                            font.italic: comboBox_server_select_italic
                            textFormat: Qt.RichText
                            color: "#666666"
                            elide: Text.ElideMiddle
                        }
                    }
                }
                contentItem: Row {
                    id: comboBox_server_select_content
                    leftPadding: 10
                    topPadding: 18

                    Image {
                        id: comboBox_server_select_content_img
                        width: 18
                        height: 18
                        source: "Resources/Icons/refresh-cw.svg"
                        verticalAlignment: Image.AlignVCenter
                        horizontalAlignment: Image.AlignLeft
                    }

                    Text {
                        text: comboBox_server_select.currentText
                        leftPadding: 10
                        clip: false
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: cantarell_regular.name
                        font.pointSize: 12
                        color: "#666666"
                    }
                }

                onCurrentIndexChanged: {
                    Launcher.set_server()
                    Launcher.refresh_status_text()
                    Launcher.get_server_information(
                                server_list_model.get(currentIndex).server_name)
                }
                onModelChanged: {
                    Launcher.set_server()
                }
            }

            Label {
                id: label_online
                x: 133
                y: 111
                width: 329
                height: 25
                color: gettingStatusColor
                text: ""
                rightPadding: 10
                verticalAlignment: Text.AlignTop
                font.family: cantarell_regular.name
                horizontalAlignment: Text.AlignRight
                font.pointSize: 10
            }

            Label {
                id: label_add_server
                x: 274
                y: 22
                width: 188
                height: 22
                color: textColorBlue
                text: qsTr("ADD NEW SERVER")
                rightPadding: 5
                verticalAlignment: Text.AlignVCenter
                font.italic: false
                font.bold: false
                font.family: cuppaJo.name
                horizontalAlignment: Text.AlignRight
                font.pointSize: 10

                MouseArea {
                    width: label_add_server.width
                    height: label_add_server.height
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        swipeView_server_select.setCurrentIndex(1)
                    }
                }
            }
        }

        // --- Page 1 - Online Server END ---

        // --- Page 2 - Local Server START ---
        Item {
            id: page_local_server
            Rectangle {
                id: button_local_save
                x: 357
                y: 143
                width: 106
                height: 27
                color: "#999999"
                opacity: 1
                rotation: 0
                visible: true
                clip: false
                z: 4

                Text {
                    id: button_local_save_text
                    x: 0
                    y: 0
                    width: 106
                    height: 27
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: "white"
                    text: "SAVE"
                    z: 1
                    font.bold: true
                    font.pointSize: 14
                    font.family: cuppaJo.name
                }

                MouseArea {
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                    anchors.rightMargin: 0
                    hoverEnabled: true
                    anchors.fill: button_local_save
                    onEntered: {
                        button_local_save.state = "Hovering"
                    }
                    onExited: {
                        button_local_save.state = ""
                    }
                    onClicked: {
                        Launcher.add_to_server_list(textField_server_name.text,
                                                    textField_server_ip.text)
                        growl.visible = true
                        swipeView_server_select.currentIndex = 0
                    }
                    onReleased: {
                        if (containsMouse)
                            button_local_save.state = "Hovering"
                        else
                            button_local_save.state = ""
                    }
                }

                states: [
                    State {
                        name: "Hovering"
                    }
                ]
                transitions: [
                    Transition {
                        from: ""
                        to: "Hovering"
                        PropertyAnimation {
                            target: button_local_save
                            properties: "scale"
                            from: 1.0
                            to: 1.1
                            duration: 200
                        }
                    },
                    Transition {
                        from: "Hovering"
                        to: "*"
                        PropertyAnimation {
                            target: button_local_save
                            properties: "scale"
                            from: 1.1
                            to: 1.0
                            duration: 200
                        }
                    }
                ]
            }
            Rectangle {
                id: button_local_back
                x: 240
                y: 143
                width: 106
                height: 27
                color: "#999999"
                opacity: 1
                rotation: 0
                visible: true
                clip: false
                z: 4

                Text {
                    id: button_local_back_text
                    x: 0
                    y: 0
                    width: 106
                    height: 27
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: "white"
                    text: "BACK"
                    z: 1
                    font.bold: true
                    font.pointSize: 14
                    font.family: cuppaJo.name
                }

                MouseArea {
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                    anchors.rightMargin: 0
                    hoverEnabled: true
                    anchors.fill: button_local_back
                    onEntered: {
                        button_local_back.state = "Hovering"
                    }
                    onExited: {
                        button_local_back.state = ""
                    }
                    onClicked: {
                        swipeView_server_select.currentIndex = 0
                    }
                    onReleased: {
                        if (containsMouse)
                            button_local_save.state = "Hovering"
                        else
                            button_local_save.state = ""
                    }
                }

                states: [
                    State {
                        name: "Hovering"
                    }
                ]
                transitions: [
                    Transition {
                        from: ""
                        to: "Hovering"
                        PropertyAnimation {
                            target: button_local_back
                            properties: "scale"
                            from: 1.0
                            to: 1.1
                            duration: 200
                        }
                    },
                    Transition {
                        from: "Hovering"
                        to: "*"
                        PropertyAnimation {
                            target: button_local_back
                            properties: "scale"
                            from: 1.1
                            to: 1.0
                            duration: 200
                        }
                    }
                ]
            }

            TextField {
                id: textField_server_ip
                x: 154
                y: 72
                text: qsTr("")
                z: 5
                placeholderText: "Server IP"
            }

            TextField {
                id: textField_server_name
                x: 154
                y: 26
                text: qsTr("")
                z: 6
                placeholderText: "Server Name"
            }
        }

        // --- Page 2 - Local Server END ---
    }

    // ---- Server Type SwipeView End ----
    Image {
        id: segs_logo
        x: 689
        y: -107
        width: 371
        height: 332
        z: 15
        source: "Resources/Images/segs-logo.png"

        NumberAnimation {
            id: segs_logo_animator
            target: segs_logo
            property: "y"
            from: -442
            to: -107
            duration: 1000
            easing.type: Easing.OutBounce
            running: true
        }
    }

    Rectangle {
        id: growl
        visible: false
        x: 674
        y: 8
        width: 376
        height: 38
        color: "#e40909"
        radius: 5
        z: 18

        Text {
            text: "Server name already exists"
            font.pointSize: 10
            font.family: cantarell_regular.name
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: "white"
        }

        PropertyAnimation {
            running: true
            target: growl
            property: 'visible'
            to: false
            duration: 3000 // turns to false after 5000 ms
        }
    }

    // SwipeView Server Info and Settings START
    SwipeView {
        id: swipeView_servinfo_settings
        anchors.right: parent.right
        anchors.rightMargin: 417
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        anchors.top: parent.top
        anchors.topMargin: 0
        z: 17
        clip: true
        interactive: false
        currentIndex: 0
        visible: true

        // Page 1 Start
        Item {
            id: page_server_info
            z: 2

            Rectangle {
                id: release_notes_header
                x: 37
                y: 9
                width: 570
                height: 36
                color: "#f1f1f1"
                z: 19
                opacity: 0.8

                Label {
                    id: label_release_notes
                    width: 392
                    color: textColorBlue
                    text: qsTr("SERVER INFO & RELEASE NOTES")
                    leftPadding: 10
                    verticalAlignment: Text.AlignVCenter
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 3
                    anchors.topMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.top: parent.top
                    z: 18
                    wrapMode: Text.WordWrap
                    styleColor: "#000000"
                    font.family: cuppaJo.name
                    horizontalAlignment: Text.AlignLeft
                    font.pointSize: 12
                    font.bold: true
                }

                Label {
                    id: label_version_info
                    color: "#666666"
                    text: ""
                    rightPadding: 10
                    anchors.rightMargin: 3
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0
                    anchors.leftMargin: 395
                    anchors.fill: parent
                    z: 19
                    verticalAlignment: Text.AlignVCenter
                    font.family: cuppaJo.name
                    horizontalAlignment: Text.AlignRight
                    font.pointSize: 12
                    font.bold: true
                }
            }

            ScrollView {
                id: scrollView_release_notes
                x: 38
                y: 60
                width: 571
                z: 20
                clip: true

                anchors.right: parent.right
                anchors.rightMargin: 61
                anchors.left: parent.left
                anchors.leftMargin: 37
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                anchors.top: parent.top
                anchors.topMargin: 121
                ScrollBar.vertical: ScrollBar {
                    policy: ScrollBar.AlwaysOn
                    parent: scrollView_release_notes
                    x: scrollView_release_notes.mirrored ? 0 : scrollView_release_notes.width
                                                           - width
                    y: scrollView_release_notes.topPadding
                    height: scrollView_release_notes.availableHeight
                    background: Rectangle {
                        color: "#0f7aff"
                    }
                }

                Text {
                    id: textArea_release_notes
                    x: 0
                    y: 0
                    width: 570
                    height: 335
                    text: ""
                    z: 3
                    wrapMode: Text.WordWrap
                    textFormat: Text.AutoText
                    opacity: 1
                    font.pointSize: 10
                    font.family: cantarell_regular.name
                    color: "black"
                    padding: 5
                }

                background: Rectangle {
                    width: textArea_release_notes.width
                    height: textArea_release_notes.height
                    color: "#F1F1F1"
                    opacity: 0.8
                }

                ScaleAnimator {
                    target: scrollView_release_notes
                    from: 0.1
                    to: 1
                    duration: 500
                    running: true
                }
            }

            Rectangle {
                id: server_info_background
                x: 37
                y: 51
                width: 570
                height: 64
                color: "#f1f1f1"
                z: 19
                opacity: 0.8

                Text {
                    id: textArea_server_info
                    color: "black"
                    text: server_info_text
                    anchors.fill: parent
                    z: 3
                    padding: 5
                    opacity: 1
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    font.pointSize: 10
                    font.family: cantarell_regular.name
                    onLinkActivated: Qt.openUrlExternally(link)

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.NoButton
                        cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                    }
                }
            }
        }

        // Page 1 End
        // Page 2 Start
        Item {
            id: page_settings

            Rectangle {
                id: rectangle
                x: 22
                y: 20
                width: 625
                height: 424
                color: "#f1f1f1"
                opacity: 0.8
            }

            Button {
                id: button_settings_save
                x: 534
                y: 377
                text: qsTr("SAVE")
                font.pointSize: 14
                font.family: cuppaJo.name
                onClicked: {
                    swipeView_servinfo_settings.currentIndex = 0
                    set_launcher_game_settings()
                }
            }

            Label {
                id: label_screen_res
                color: "#0f7aff"
                text: qsTr("SCREEN RESOLUTION")
                font.bold: true
                font.pointSize: 14
                anchors.right: parent.right
                anchors.rightMargin: 490
                anchors.left: parent.left
                anchors.leftMargin: 33
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 360
                anchors.top: parent.top
                anchors.topMargin: 77
                font.family: cuppaJo.name
            }

            TextField {
                id: textField_screen_x
                text: qsTr("")
                font.family: cantarell_regular.name
                anchors.right: parent.right
                anchors.rightMargin: 579
                anchors.left: parent.left
                anchors.leftMargin: 33
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 321
                anchors.top: parent.top
                anchors.topMargin: 103
                placeholderText: ""
                background: Rectangle {
                    color: "#f1f1f1"
                }
            }

            TextField {
                id: textField_screen_y
                width: 56
                font.family: cantarell_regular.name
                anchors.right: parent.right
                anchors.rightMargin: 504
                anchors.left: parent.left
                anchors.leftMargin: 110
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 322
                anchors.top: parent.top
                anchors.topMargin: 104
                placeholderText: ""
                background: Rectangle {
                    color: "#f1f1f1"
                }
            }

            Label {
                id: label_screen_res1
                height: 28
                color: "#0f7aff"
                text: qsTr("X")
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 327
                anchors.top: parent.top
                anchors.topMargin: 109
                anchors.right: parent.right
                anchors.rightMargin: 564
                anchors.left: parent.left
                anchors.leftMargin: 95
                font.pointSize: 14
                font.family: cuppaJo.name
                font.bold: true
            }

            Label {
                id: label_full_screen
                color: "#0f7aff"
                text: qsTr("FULL SCREEN")
                font.bold: true
                font.pointSize: 14
                anchors.right: parent.right
                anchors.rightMargin: 538
                anchors.left: parent.left
                anchors.leftMargin: 33
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 278
                anchors.top: parent.top
                anchors.topMargin: 162
                font.family: cuppaJo.name
            }

            CheckBox {
                id: checkBox_fullscreen
                anchors.right: parent.right
                anchors.rightMargin: 461
                anchors.left: parent.left
                anchors.leftMargin: 161
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 270
                anchors.top: parent.top
                anchors.topMargin: 154
            }
        }
    }

    Image {
        id: background_rectangle
        x: 0
        y: 0
        width: 1100
        height: 494
        fillMode: Image.Stretch
        source: "Resources/Images/background_rectangle.png"
    }

    Image {
        id: hero_image
        x: -453
        y: -283
        width: 942
        height: 683
        fillMode: Image.PreserveAspectFit
        source: "Resources/Images/bluestreak.png"
    }

    // SwipeView Server Info and Settings END
}
