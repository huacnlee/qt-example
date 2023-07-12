import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

TabBar {
    id: control

    padding: 4

    background: Rectangle {
        anchors.fill: parent
        color: LBTheme.colors.muted
        radius: 8
    }
}
