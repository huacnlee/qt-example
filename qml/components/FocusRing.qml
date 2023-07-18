import QtQuick
import QtQuick.Controls
import FluentUI
import "../theme.mjs" as LBTheme

Item {
    id: control
    property int radius: 6
    anchors.fill: parent
    Rectangle {
        width: parent.width + 2
        height: parent.height + 2
        x: -1
        y: -1
        anchors.centerIn: parent
        border.width: 2.5
        color: "transparent"
        radius: control.radius
        border.color: LBTheme.colors.focusRing
    }
}
