import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import "main.mjs" as MainJS
import "components"
import Qt.labs.qmlmodels
import QtExample 1.0

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
            text: "Total Count: " + tableView.rows + " items" + ", current: " + tableView.currentRow + "," + tableView.currentColumn
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
        color: "#f0f0f0"

        TableHeader {
            id: horizontalHeader
            Layout.fillWidth: true
            Layout.fillHeight: true
            syncView: tableView

            model: ListModel {
                ListElement {
                    display: "Name"
                    // width: 120
                }
                ListElement {
                    display: "Code"
                    // width: 120
                }
                ListElement {
                    display: "Price"
                    // width: 120
                    align: Text.AlignRight
                }
            }
        }

        SelectionRectangle {
            target: tableView
        }

        TableView {
            id: tableView
            anchors.top: horizontalHeader.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            interactive: true

            model: SimpleModel {
                id: watchlistModel
            }

            delegate: TableCell {
                selected: tableView.currentRow == row

                readonly property color upColor: Qt.alpha(MainJS.appColors.trendColor.up, 0.1)
                readonly property color downColor: Qt.alpha(MainJS.appColors.trendColor.down, 0.1)
                readonly property color bgColor: "#FFFFFF"

                color: bgColor

                TableView.onCommit: {
                    console.log("----------- TableView.onResued");
                    bgColorAnimation.restart();
                }

                ColorAnimation on color  {
                    id: bgColorAnimation
                    duration: 100
                    from: up_down == 1 ? upColor : up_down == -1 ? downColor : bgColor
                    to: bgColor
                }

                // implicitWidth: column == 0 ? 520 : 180
                implicitHeight: 48

                Text {
                    anchors.fill: parent
                    visible: column != 2
                    verticalAlignment: Text.AlignVCenter
                    text: display
                    elide: Text.ElideRight
                    font.weight: column == 0 ? Font.DemiBold : Font.Normal
                    color: "#000000"
                }

                PriceTag {
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    visible: column == 2
                    upDown: up_down
                    value: last_done
                }
            }
        }
    }
}
