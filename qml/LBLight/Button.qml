import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

Button {
    id: control
    property var type: "default"
    property var size: "md"
    property var style: LBTheme.btnStyle(control)
    property var sizes: LBTheme.btnSize(control)
    leftPadding: sizes.padding
    rightPadding: sizes.padding
    activeFocusOnTab: true
    focusPolicy: Qt.StrongFocus

    contentItem: Text {
        text: control.text
        opacity: enabled ? 1.0 : 0.3
        color: LBTheme.btnStyle(control).color
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        anchors.fill: parent
        implicitWidth: sizes.width
        implicitHeight: sizes.height
        opacity: enabled ? 1 : 0.3
        color: style.backgroundColor
        border.width: 1
        border.color: style.borderColor
        radius: sizes.radius
        layer.enabled: true
        layer.effect: Shadow {
            size: "sm"
        }
    }
}
