import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

TableView {
    columnSpacing: 0
    rowSpacing: 0
    clip: true

    ScrollBar.vertical: ScrollBar {
    }
    ScrollBar.horizontal: ScrollBar {
    }

    interactive: true
    boundsBehavior: Flickable.StopAtBounds
    selectionBehavior: TableView.SelectRows
    alternatingRows: true

    implicitWidth: Math.max(1, contentWidth)

    selectionModel: ItemSelectionModel {
    }
}
