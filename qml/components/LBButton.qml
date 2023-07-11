import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Basic

Button {
    id: control
    background: Rectangle {
        border.color: {
            if (!enabled) {
                return "#808080";
            }
            if (pressed) {
                return "#404040";
            }
            if (hovered) {
                return "#202020";
            }
            if (control.focus) {
                return "#000000";
            }
            hovered ? "#000000" : "#202020";
        }
        color: {
            if (pressed) {
                return "#f0f0f0";
            }
            return "#ffffff";
        }
        radius: 2
    }
}
