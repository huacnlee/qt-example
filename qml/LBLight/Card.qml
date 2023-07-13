import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Basic
import "theme.mjs" as LBTheme

Rectangle {
    id: control
    default property alias content: container.data
    border.color: LBTheme.colors.border
    border.width: 1
    color: LBTheme.colors.card
    radius: LBTheme.borderRadius.lg
    property int paddings: 24

    Shadow {
    }

    Column {
        id: container
        anchors.fill: parent
        anchors.margins: paddings
    }
}
