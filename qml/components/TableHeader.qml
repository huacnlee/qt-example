import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

HorizontalHeaderView {
    id: control
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    height: 40
    clip: true

    // background: Rectangle {
    //     color: LBTheme.Colors.tableBackground
    // }

    boundsBehavior: Flickable.StopAtBounds
    syncDirection: Qt.Horizontal

    delegate: TableHeaderCell {
        implicitHeight: 40
        implicitWidth: 100

        Text {
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: model.align ? model.align : Text.AlignLeft
            text: display
        }
    }
}
