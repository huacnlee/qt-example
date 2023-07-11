import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme
import "base"

Button {
    function btnSize(control) {
        const { size } = control

        switch (size) {
            case "lg":
                return {
                    padding: 24,
                    width: 100,
                    height: 45,
                    radius: 8,
                }
            case "sm":
                return {
                    padding: 8,
                    width: 56,
                    height: 24,
                    radius: 4,
                }
            default:
                return {
                    padding: 16,
                    width: 76,
                    height: 36,
                    radius: 6,
                }
        }
    }

    function btnStyle(control) {
        let { type, hovered, enabled } = control
        if (!enabled) {
            hovered = false
        }
        
        const { colors, opacity } = LBTheme
        switch (type) {
            case 'primary':
                return {
                    backgroundColor: hovered ? opacity(colors.primary, 90) : colors.primary,
                    color: colors.primaryForeground,
                    borderColor: colors.primary,
                };
            case "danger":
                return {
                    backgroundColor: hovered ? opacity(colors.danger, 90) : colors.danger,
                    color: colors.dangerForeground,
                    borderColor: colors.danger,
                }
            default:
                return {
                    backgroundColor: hovered ? colors.accent : colors.background,
                    color: colors.secondaryForeground,
                    borderColor: colors.input,
                };
        }
    }


    id: control
    property var type: "default"
    property var size: "md"
    leftPadding: sizes.padding
    rightPadding: sizes.padding

    property var style: btnStyle(control)
    property var sizes: btnSize(control)

    contentItem: Text {
        text: control.text
        opacity: enabled ? 1.0 : 0.3
        color: btnStyle(control).color
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        implicitWidth: sizes.width
        implicitHeight: sizes.height
        opacity: enabled ? 1 : 0.3
        color: style.backgroundColor
        border.width: 1
        border.color: style.borderColor
        radius: sizes.radius
        layer.enabled: true
        layer.effect: ShadowSM {
        }
    }
}
