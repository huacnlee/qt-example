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
        implicitWidth: parent.width
        implicitHeight: sizes.height
        radius: sizes.radius
        color: control.enabled ? LBTheme.colors.background : LBTheme.colors.muted
        border.color: control.activeFocus ? LBTheme.colors.focusRing : LBTheme.colors.input
        border.width: control.activeFocus ? 2 : 1
    }
}
