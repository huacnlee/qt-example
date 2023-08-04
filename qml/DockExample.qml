import Qt.labs.platform
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import "main.mjs" as MainJS
import "components"
import "dock"

Rectangle {
    anchors.fill: parent

    DockContainer {
        id: dockHome
        anchors.margins: 2
        state: DockBase.DockState.Fill

        Dock {
            id: dockWatchlist
            dockHome: dockHome
            closable: false
            name: "Watchlist"
            state: DockBase.DockState.Fill
            direction: Dock.Direction.Left
            width: 300
            height: 200
        }

        Dock {
            id: dockCharts
            dockHome: dockHome
            closable: false
            name: "Charts"
            state: DockBase.DockState.Fill
            direction: Dock.Direction.Right
            width: 300
            height: 200
        }
    }
}
