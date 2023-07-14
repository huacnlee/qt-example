import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

Rectangle {
    id: control
    default property alias content: contentWrap.children
    property int padding: 0
    border.width: 1
    border.color: LBTheme.colors.border
    color: LBTheme.colors.muted
    radius: LBTheme.radius
    clip: true

    Rectangle {
        id: contentWrap
        color: "transparent"
        clip: true
        anchors {
            margins: padding + control.border.width
            fill: parent
        }

        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Rectangle {
                width: control.width
                height: control.height
                radius: control.radius
            }
        }
    }
}
