import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

Dialog {
    id: control
    anchors.centerIn: Overlay.overlay
    horizontalPadding: 32
    height: contentHeight + header.height + 32
    focus: true

    readonly property int popupOffset: control.contentHeight / 2

    header: Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 48
        color: "transparent"

        Row {
            anchors.fill: parent
            anchors.leftMargin: control.horizontalPadding
            anchors.rightMargin: control.horizontalPadding

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: control.title
                font.pixelSize: 16
                color: LBTheme.colors.foreground
            }
        }
    }

    background: Rectangle {
        id: background
        color: LBTheme.colors.card
        border.width: 1
        border.color: LBTheme.colors.border
        radius: LBTheme.borderRadius.lg

        layer.enabled: true
        layer.effect: Shadow {
            size: "lg"
        }
    }

    Overlay.modal: Rectangle {
        color: "#20000000"
    }

    enter: Transition {
        PropertyAnimation {
            properties: "scale"
            from: 0.95
            to: 1
            duration: 150
        }
        PropertyAnimation {
            properties: "y"
            from: parent.height
            duration: 150
        }
        NumberAnimation {
            property: "opacity"
            from: 0
            to: 1
            duration: 150
        }
    }
    exit: Transition {
        PropertyAnimation {
            properties: "scale"
            from: 1
            to: 0.95
            duration: 150
        }
        // PropertyAnimation {
        //     properties: "y"
        //     from: parent.height + popupOffset
        //     to: parent.height - popupOffset
        //     duration: 150
        // }
        NumberAnimation {
            property: "opacity"
            from: 1
            to: 0
            duration: 150
        }
    }
}
