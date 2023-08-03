import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

Switch {
    id: control

    indicator: Rectangle {
        id: indicatorBg
        implicitWidth: 36
        implicitHeight: 20
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        radius: 100
        color: control.checked ? LBTheme.colors.primary : LBTheme.colors.input
        opacity: enabled ? 1.0 : 0.6

        Behavior on color  {
            ColorAnimation {
                duration: 50
                easing.type: Easing.Linear
            }
        }

        Rectangle {
            id: indicator

            readonly property int innerPadding: 2
            readonly property int indicatorWidth: down ? 20 : 16
            readonly property int indicatorHeight: 16

            y: innerPadding
            x: control.checked ? parent.width - indicatorWidth - innerPadding : innerPadding
            width: indicatorWidth
            height: indicatorHeight
            radius: 100
            color: LBTheme.colors.card

            layer.enabled: true
            layer.effect: Shadow {
                size: "sm"
            }

            Behavior on width  {
                NumberAnimation {
                    duration: 150
                }
            }
            Behavior on x  {
                NumberAnimation {
                    duration: 150
                    // https://doc.qt.io/qt-6/qml-qtquick-propertyanimation.html#easing.bezierCurve-prop
                    easing.type: Easing.InQuad
                }
            }
        }
    }

    contentItem: Text {
        text: control.text
        opacity: enabled ? 1.0 : 0.3
        color: LBTheme.colors.foreground
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator.width + control.spacing
    }
}
