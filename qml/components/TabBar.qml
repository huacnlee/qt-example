import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

TabBar {
    id: control
    padding: 4
    property int radius: LBTheme.borderRadius.lg

    background: Rectangle {
        anchors.fill: parent
        color: LBTheme.colors.muted
        radius: control.radius
    }
}
