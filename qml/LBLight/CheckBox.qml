import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "base"
import "theme.mjs" as LBTheme

CheckBox {
    id: control
    text: qsTr("CheckBox")
    focusPolicy: Qt.StrongFocus
    activeFocusOnTab: true

    indicator: Rectangle {
        implicitWidth: 16
        implicitHeight: 16
        opacity: enabled ? 1.0 : 0.1
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        radius: 4
        border.color: "#18181B"

        Rectangle {
            width: 16
            height: 16
            x: 0
            y: 0
            radius: 4
            color: LBTheme.colors.primary
            visible: control.checked

            FocusRing {
                radius: 4
                visible: control.activeFocus
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
    contentItem: Text {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: LBTheme.colors.foreground
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator.width + control.spacing
    }
}
