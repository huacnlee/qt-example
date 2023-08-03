import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

Button {
    id: control
    property string size: "md"
    property string src
    anchors.verticalCenter: parent.verticalCenter
    width: LBTheme.avatarSizes[control.size] || LBTheme.avatarSizes.md
    height: control.width

    background: Rectangle {
        radius: 100
    }

    Image {
        id: img
        anchors.fill: parent
        source: src
        fillMode: Image.PreserveAspectFit
        opacity: down ? 0.9 : 1

        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Item {
                width: img.width
                height: img.height
                Rectangle {
                    anchors.centerIn: parent
                    width: img.adapt ? img.width : Math.min(img.width, img.height)
                    height: img.adapt ? img.height : width
                    radius: Math.min(width, height)
                }
            }
        }
    }
}
