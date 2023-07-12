import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Basic
import "theme.mjs" as LBTheme
import "base"

Rectangle {
    id: control
    default property alias content: container.data
    border.color: LBTheme.colors.border
    border.width: 1
    color: LBTheme.colors.card
    radius: 8
    property int paddings: 12

    Shadow {
    }

    Item {
        id: container
        anchors.fill: parent
        anchors.margins: paddings
    }
}
