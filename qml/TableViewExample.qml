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

    Panel {
        Layout.fillHeight: true
        Layout.fillWidth: true

        TableHeader {
            id: horizontalHeader
            syncView: tableView
            delegate: TableHeaderCell {
                implicitHeight: 40

                Text {
                    text: display
                }
            }
        }

        TableView {
            id: tableView
            anchors.top: horizontalHeader.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            model: Watchlist {
                id: watchlistModel
            }

            delegate: TableCell {
                required property bool current
                required property bool selected

                readonly property color upColor: MainJS.appColors.trendColor.up
                readonly property color downColor: MainJS.appColors.trendColor.down

                implicitWidth: 120
                implicitHeight: 48
                color: selected ? "#F4F4F5" : up_down == -1 ? Qt.alpha(downColor, 0.1) : up_down == 1 ? Qt.alpha(upColor, 0.1) : "#ffffff"

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
}