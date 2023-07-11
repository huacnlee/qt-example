import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects

CheckBox {
    id: control
    text: qsTr("CheckBox")
    property var clickListener: function () {
        checked = !checked;
    }

    indicator: Rectangle {
        implicitWidth: 16
        implicitHeight: 16
        opacity: enabled ? 1.0 : 0.1
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        radius: 4
        border.color: "#18181B"

        Rectangle {
            width: 16
            height: 16
            x: 0
            y: 0
            radius: 4
            color: "#18181B"
            visible: control.checked
        }
        Image {
            id: check_img
            width: 14
            height: 14
            x: 1
            y: 1
            source: "assets/checkbox-check.svg"
            sourceSize.width: 14
            sourceSize.height: 14
            visible: control.checked
        }
        ColorOverlay {
            anchors.fill: check_img
            source: check_img
            color: "#ffffff"
            transform: rotation
        }
    }
    onClicked: clickListener()
    contentItem: Text {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: "#18181B"
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator.width + control.spacing
    }
}
