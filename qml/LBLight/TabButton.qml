import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

TabButton {
    id: control
    verticalPadding: 4
    horizontalPadding: 12

    background: Rectangle {
        anchors.fill: parent
        implicitHeight: 28
        implicitWidth: 95
        color: control.checked ? LBTheme.colors.background : "transparent"
        radius: 4
        layer.enabled: true
        layer.effect: Shadow {
            size: "sm"
        }
    }

    contentItem: Text {
        text: control.text
        color: LBTheme.colors.foreground
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
