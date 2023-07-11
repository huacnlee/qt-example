import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Basic

Text {
    id: control
    property var upDown: 0
    property var price: 0
    color: upDown > 0 ? "green" : upDown < 0 ? "red" : "black"
    text: (upDown > 0 ? "▲" : upDown < 0 ? "▼" : "") + " " + price
}
