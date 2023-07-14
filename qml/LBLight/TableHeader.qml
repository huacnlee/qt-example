import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

TableView {
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    height: 40

    boundsBehavior: Flickable.StopAtBounds
    syncDirection: Qt.Horizontal
}
