import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

TableView {
    id: control
    columnSpacing: 1
    rowSpacing: 0.3
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

    columnWidthProvider: function (column) {
        let w = explicitColumnWidth(column);
        if (w >= 0)
            return w;

        // default return columnWidth tableWidth / columnCount for full width
        return control.model ? control.width / 3 - 1 : 0;
    }
}
