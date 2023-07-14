import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import "main.mjs" as MainJS
import "LBLight"
import Qt.labs.qmlmodels
import com.company.example 1.0

ColumnLayout {
    anchors.fill: parent
    spacing: 12

    Timer {
        id: timer
    }

    Timer {
        id: timerAutoRefesh
    }

    Component.onCompleted: {
        reloadData();
    }

    function reloadData() {
        watchlistModel.reload();
        tableView.forceLayout();
    }

    RowLayout {
        id: toolbarRow
        spacing: 10

        Button {
            id: btnReload
            text: "Reload"
            onClicked: {
                btnReload.loading = true;
                timer.setTimeout(150, function () {
                        btnReload.loading = false;
                    });
                reloadData();
            }
        }

        Text {
            Layout.alignment: Qt.AlignVCenter
            text: "Total Count: " + (tableView.rowCount || 0) + " items"
        }

        Button {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            text: "Auto Refresh"
            checkable: true
            onCheckedChanged: {
                if (checked) {
                    timerAutoRefesh.restart();
                } else {
                    timerAutoRefesh.stop();
                }
            }
            Component.onCompleted: {
                timerAutoRefesh.setInterval(150, () => {
                        reloadData();
                    });
                timerAutoRefesh.stop();
            }
        }
    }

    Rectangle {
        Layout.fillHeight: true
        Layout.fillWidth: true
        border.width: 1
        border.color: "#f0f0f0"
        color: "#f9f9f7"
        radius: 8

        HorizontalHeaderView {
            id: horizontalHeader
            anchors.left: tableView.left
            anchors.top: parent.top
            syncView: tableView
            textRole: "display"
            boundsBehavior: Flickable.StopAtBounds
            model: TableModel {
                TableModelColumn {
                    display: "Name"
                }
                TableModelColumn {
                    display: "Code"
                }
                TableModelColumn {
                    display: "Last Done"
                }
            }
        }

        TableView {
            id: tableView
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.top: horizontalHeader.bottom
            selectionBehavior: TableView.SelectRows
            columnSpacing: 0
            rowSpacing: 0

            ScrollBar.vertical: ScrollBar {
            }
            boundsBehavior: Flickable.StopAtBounds

            model: Watchlist {
                id: watchlistModel
            }

            delegate: Rectangle {
                required property bool current
                required property bool selected

                readonly property color upColor: MainJS.appColors.trendColor.up
                readonly property color downColor: MainJS.appColors.trendColor.down

                implicitWidth: 120
                implicitHeight: 48
                color: selected ? "#F4F4F5" : up_down == -1 ? Qt.alpha(downColor, 0.1) : up_down == 1 ? Qt.alpha(upColor, 0.1) : "#ffffff"

                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 6
                    color: "transparent"

                    PriceTag {
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        visible: column == 2
                        upDown: up_down
                        value: last_done
                    }

                    Text {
                        anchors.fill: parent
                        visible: column != 2
                        verticalAlignment: Text.AlignVCenter
                        text: display
                        elide: Text.ElideRight
                        color: "#000000"
                    }
                }
            }
        }

        layer.enabled: true
        layer.effect: Shadow {
            size: "sm"
        }
    }
}
