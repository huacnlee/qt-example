import Qt.labs.platform
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls.Basic
import "main.mjs" as MainJS
import "LBLight"

// This must match the qml_uri and qml_version
// specified with the #[cxx_qt::qobject] macro in Rust.
import com.company.example 1.0

Window {
    id: app
    title: "QT Example"
    visible: true
    width: 1000
    height: 640

    MyObject {
        id: myObject
        number: 1
        string: "Hello, this is number: " + myObject.number
    }

    Watchlist {
        id: myWatchlist
    }

    Component.onCompleted: {
        reloadData();
    }

    function reloadData() {
        myObject.incrementNumber();
        myWatchlist.prepare();

    // MainJS.loadData(myObject, mainTableView, {tableRowAction, tableRowLastDone});
    }

    onClosing: {
        // closeDialog.open();
        return false;
    }

    Column {
        anchors.top: parent.top
        padding: 10
        spacing: 10

        Row {
            spacing: 6
            Label {
                text: "Number: " + myObject.number
            }

            Label {
                text: "String: " + myObject.string
            }

            Text {
                text: "You Name:"
                onTextChanged: myObject.string = text
            }
        }

        Row {
            spacing: 6
            Button {
                type: "primary"
                text: "Reload Data"

                onClicked: () => {
                    reloadData();
                }
            }

            Button {
                type: "danger"
                text: "Delete"
            }

            Button {
                type: "primary"
                enabled: false
                text: "Disabled Button"

                onClicked: () => {
                    reloadData();
                }
            }

            Button {
                type: "danger"
                enabled: false
                text: "Disabled Danger"

                onClicked: () => {
                    reloadData();
                }
            }
        }

        Row {
            spacing: 6

            Button {
                text: "Button"

                onClicked: myObject.sayHi(myObject.string, myObject.number)
            }

            Button {
                text: "Large Button!"
                size: "lg"

                onClicked: myObject.sayHi(myObject.string, myObject.number)
            }

            Button {
                text: "Small Button"
                size: "sm"

                onClicked: myObject.sayHi(myObject.string, myObject.number)
            }

            Button {
                text: "Button Disabled"
                enabled: false

                onClicked: myObject.sayHi(myObject.string, myObject.number)
            }
        }

        Row {
            spacing: 6

            CheckBox {
                text: "CheckBox"
            }

            CheckBox {
                checkable: true
                checked: true
                text: "CheckBox Checked"
            }

            CheckBox {
                enabled: false
                checked: false
                text: "CheckBox Disabled"
            }
            CheckBox {
                enabled: false
                checked: true
                text: "CheckBox Checked Disabled"
            }
        }

        Row {
            spacing: 6

            ComboBox {
                model: ["Item 1", "Item 2", "Item 3"]
            }
        }

        Component {
            id: tableRowAction
            Item {
                RowLayout {
                    anchors.centerIn: parent
                    Button {
                        text: "Buy"
                        onClicked: {
                            showInfo("You clicked Buy.");
                        }
                    }
                    Button {
                        text: "Sell"
                        onClicked: {
                            showInfo("You clicked Sell.");
                        }
                    }
                }
            }
        }

        Component {
            id: tableRowLastDone

            Item {
                readonly property var obj: tableModel.getRow(row)
                RowLayout {
                    anchors.centerIn: parent

                    LBPrice {
                        price: obj.last_done_val
                        upDown: obj.up_down
                    }
                }
            }
        }

        TableView {
            id: mainTableView
            anchors.fill: parent
            anchors.topMargin: 64
            resizableColumns: true
            model: myWatchlist
            delegate: Rectangle {
                implicitWidth: 100
                implicitHeight: 50
                Label {
                    text: name
                    anchors.centerIn: parent
                }
            }
        }

        // FluTableView {
        //     id: mainTableView
        //     anchors.fill: parent
        //     anchors.topMargin: 64
        //     columnSource: [{
        //             "title": 'Name',
        //             "dataIndex": 'name',
        //             "width": 100,
        //             "minimumWidth": 80,
        //             "maximumWidth": 200,
        //             "readOnly": true
        //         }, {
        //             "title": 'Code',
        //             "dataIndex": 'code',
        //             "width": 100,
        //             "minimumWidth": 100,
        //             "maximumWidth": 100,
        //             "readOnly": true
        //         }, {
        //             "title": 'Last Done',
        //             "dataIndex": 'last_done',
        //             "width": 200,
        //             "minimumWidth": 100,
        //             "align": 'right',
        //             "readOnly": true
        //         }, {
        //             "title": 'Action',
        //             "dataIndex": 'action',
        //             "width": 160,
        //             "minimumWidth": 160,
        //             "maximumWidth": 160,
        //             "readOnly": true
        //         }]
        // }
    }
}
