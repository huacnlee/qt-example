import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "base"
import "theme.mjs" as LBTheme

Switch {
    id: control
    text: qsTr("Switch")

    indicator: Rectangle {
        id: indicatorBg
        implicitWidth: 36
        implicitHeight: 20
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        radius: 100
        color: control.checked ? LBTheme.colors.primary : LBTheme.colors.input

        Behavior on color  {
            ColorAnimation {
                duration: 50
                easing.type: Easing.Linear
            }
        }

        Rectangle {
            y: 2
            x: control.checked ? parent.width - width - 2 : 2
            width: 16
            height: 16
            radius: 100
            color: LBTheme.colors.card

            layer.enabled: true
            layer.effect: ShadowSM {
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
        font.weight: Font.DemiBold
        opacity: enabled ? 1.0 : 0.3
        color: LBTheme.colors.foreground
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator.width + control.spacing
    }
}