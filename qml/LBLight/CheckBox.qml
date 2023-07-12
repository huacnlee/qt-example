import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

CheckBox {
    id: control
    text: qsTr("CheckBox")
    focusPolicy: Qt.StrongFocus
    property string description: ""
    property var hasDescription: description !== ""
    spacing: 4

    // Checkbox
    indicator: Rectangle {
        anchors.top: parent.top
        implicitWidth: 16
        implicitHeight: 16
        opacity: enabled ? 1.0 : 0.1
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        radius: 4
        border.color: "#18181B"

        // Checked
        Rectangle {
            width: 16
            height: 16
            x: 0
            y: 0
            radius: 4
            color: LBTheme.colors.primary
            visible: control.checked

            layer.enabled: true
            layer.effect: Shadow {
            }
        }
        Image {
            id: check_img
            width: 14
            height: 14
            x: 1
            y: 1
            source: "assets/checkbox-check.svg"
            sourceSize.width: 14
            sourceSize.height: 14
            visible: control.checked
        }
        ColorOverlay {
            anchors.fill: check_img
            source: check_img
            color: "#ffffff"
            transform: rotation
        }
    }

    // Label
    contentItem: Column {
        spacing: control.spacing
        anchors.top: parent.top
        leftPadding: control.indicator.width + control.spacing + 2

        Label {
            text: control.text
            font.weight: hasDescription ? Font.DemiBold : Font.Normal
            opacity: enabled ? 1.0 : 0.3
            color: LBTheme.colors.foreground
        }

        Label {
            anchors.topMargin: control.spacing
            visible: hasDescription
            text: control.description
            opacity: enabled ? 1.0 : 0.3
            color: LBTheme.colors.mutedForeground
        }
    }
}
