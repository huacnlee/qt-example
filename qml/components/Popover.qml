import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import QtQuick.Shapes
import "theme.mjs" as LBTheme

Popup {
    id: control

    default property alias content: inner.children

    property string trigger: "both"
    property bool showClose: true
    readonly property int cornerSize: 8
    readonly property int popupOffset: 4
    readonly property int minWidth: 300
    readonly property int maxWidth: 640
    readonly property int maxHeight: 480

    Component.onCompleted: {
        parent.hoverEnabled = true;
    }

    // connect click for button
    Connections {
        target: parent

        function onClicked(mouse) {
            if (trigger == "both" || trigger == "click") {
                control.open();
            }
        }
    }

    visible: {
        if (trigger == "both" || trigger == "hover") {
            return mouseArea.containsMouse || parent.hovered || false;
        }
        return control.opened;
    }

    x: parent.width / 2 - width / 2
    y: parent.height
    margins: 12
    width: Math.min(Math.max(inner.width, minWidth), maxWidth)
    height: Math.min(inner.childrenRect.height + padding * 2, maxHeight)
    padding: 24

    Item {
        id: inner
    }

    background: Rectangle {
        id: bg
        border.color: LBTheme.colors.border
        radius: LBTheme.radius

        layer.enabled: true
        layer.effect: Shadow {
            size: "lg"
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            preventStealing: true
        }

        RoundButton {
            id: closeBtn
            visible: showClose
            anchors.right: bg.right
            anchors.top: bg.top
            anchors.margins: 10
            width: 20
            height: 20
            hoverEnabled: true

            background: Rectangle {
                color: closeBtn.hovered ? LBTheme.colors.muted : "transparent"
                radius: 100
                opacity: 0.8
            }

            Icon {
                anchors.centerIn: parent
                name: "close"
                opacity: closeBtn.hovered ? 1 : 0.5
            }

            onClicked: {
                control.close();
            }
        }
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
            from: parent.height - popupOffset
            to: parent.height + popupOffset
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
        PropertyAnimation {
            properties: "y"
            from: parent.height + popupOffset
            to: parent.height - popupOffset
            duration: 150
        }
        NumberAnimation {
            property: "opacity"
            from: 1
            to: 0
            duration: 150
        }
    }
}
