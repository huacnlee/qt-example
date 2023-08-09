import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

Frame {
    id: control
    clip: true
    readonly property int radius: LBTheme.radius

    background: Rectangle {
        color: "transparent"
        border {
            color: LBTheme.colors.border
            width: 1
        }
        radius: control.radius

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
