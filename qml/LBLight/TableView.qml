import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

TableView {
    selectionBehavior: TableView.SelectRows
    columnSpacing: 0
    rowSpacing: 0
    clip: true

    ScrollBar.vertical: ScrollBar {
    }

    boundsBehavior: Flickable.StopAtBounds
}
