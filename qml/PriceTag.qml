import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Basic
import "main.mjs" as MainJS

Text {
    id: control
    horizontalAlignment: Text.AlignRight
    property var upDown: 0
    property var value: 0
    color: upDown > 0 ? "green" : upDown < 0 ? "red" : "black"
    text: (upDown > 0 ? "+" : upDown < 0 ? "-" : "") + MainJS.formatNumber(control.value)
}
