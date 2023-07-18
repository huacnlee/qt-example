import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

Rectangle {
    id: control
    required property string text
    property string type: "default"
    property bool cycle: false
    readonly property var styles: LBTheme.btnStyle(control)

    color: styles.backgroundColor
    radius: LBTheme.radius
    height: 22
    width: label.width
    border.color: styles.borderColor
    border.width: 1

    Text {
        id: label
        anchors.centerIn: parent
        leftPadding: 10
        rightPadding: 10
        text: control.text
        color: styles.color
        font.pixelSize: 12
    }

    layer.enabled: true
    layer.effect: Shadow {
        size: "sm"
    }
}
