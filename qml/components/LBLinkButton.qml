import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Basic

Button {
    id: control

    background: Rectangle {
        border.width: 0
        color: {
            return "transparent";
        }
        radius: 0
    }
    contentItem: Text {
        text: control.text
        color: !pressed ? "#000000" : "#1b7ff5"
    }
}
