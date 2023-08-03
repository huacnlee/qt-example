import QtQuick
import QtQuick.Controls.Basic
import "theme.mjs" as LBTheme

TextArea {
    id: control
    signal commit
    property var sizes: LBTheme.btnSize(control)
    activeFocusOnTab: true
    activeFocusOnPress: true
    focus: true
    padding: sizes.padding

    color: LBTheme.colors.foreground

    background: Rectangle {
        anchors.fill: parent
        radius: sizes.radius
        implicitHeight: 100
        implicitWidth: 250
        color: control.enabled ? LBTheme.colors.background : LBTheme.colors.muted
        border.color: LBTheme.colors.border
        border.width: 1
    }
}
