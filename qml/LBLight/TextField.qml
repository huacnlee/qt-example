import QtQuick
import QtQuick.Controls.Basic
import "theme.mjs" as LBTheme

TextField {
    id: control
    signal commit
    property var size: "md"
    property var sizes: LBTheme.btnSize(control)
    leftPadding: sizes.padding
    rightPadding: sizes.padding
    activeFocusOnTab: true
    activeFocusOnPress: true
    focus: true

    color: LBTheme.colors.foreground

    background: Rectangle {
        anchors.fill: parent
        implicitHeight: sizes.height
        radius: sizes.radius
        color: control.enabled ? LBTheme.colors.background : LBTheme.colors.muted
        border.color: LBTheme.colors.border
        border.width: 1
    }
}
