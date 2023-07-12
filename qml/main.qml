import Qt.labs.platform
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import "main.mjs" as MainJS
import "LBLight"
import com.company.example 1.0

ApplicationWindow {
    id: app
    title: "QT Example"
    width: 1000
    height: 640
    visible: true

    function reloadData() {
        myObject.incrementNumber();
        myWatchlist.prepare();

    // MainJS.loadData(myObject, mainTableView, {tableRowAction, tableRowLastDone});
    }

    MouseArea {
        anchors.fill: parent
        onClicked: forceActiveFocus()
    }

    Component.onCompleted: {
        reloadData();
    }
    onClosing: {
        // closeDialog.open();
        return false;
    }

    MyObject {
        id: myObject
        number: 1
        string: "Hello, this is number: " + myObject.number
    }
    Watchlist {
        id: myWatchlist
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16

        TabBar {
            id: mainTabBar
            currentIndex: 2

            Repeater {
                model: ["Button", "CheckBox", "Input", "Avatar", "Table"]
                TabButton {
                    text: modelData
                    width: 100
                }
            }
        }

        StackLayout {
            id: mainStockTabs
            currentIndex: mainTabBar.currentIndex

            Card {
                id: buttonsTab

                Column {
                    spacing: 16
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
                            text: "Reload Data"
                            type: "primary"
                            focus: true

                            onClicked: {
                                reloadData();
                            }
                        }
                        Button {
                            text: "Delete"
                            type: "danger"
                        }
                        Button {
                            enabled: false
                            text: "Disabled Button"
                            type: "primary"
                        }
                        Button {
                            enabled: false
                            text: "Disabled Danger"
                            type: "danger"

                            onClicked: {
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
                            size: "lg"
                            text: "Large Button!"

                            onClicked: myObject.sayHi(myObject.string, myObject.number)
                        }
                        Button {
                            size: "sm"
                            text: "Small Button"

                            onClicked: myObject.sayHi(myObject.string, myObject.number)
                        }
                        Button {
                            enabled: false
                            text: "Button Disabled"

                            onClicked: myObject.sayHi(myObject.string, myObject.number)
                        }
                    }
                }
            }
            Card {
                id: checkboxTab
                Column {
                    spacing: 16
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
                            checked: false
                            enabled: false
                            text: "CheckBox Disabled"
                        }
                        CheckBox {
                            checked: true
                            enabled: false
                            text: "CheckBox Checked Disabled"
                        }
                    }

                    Column {
                        spacing: 6

                        CheckBox {
                            text: "CheckBox with Description"
                            description: "Description can be used to add more information about the checkbox.\nThis is second line."
                        }

                        CheckBox {
                            text: "CheckBox"
                            enabled: false
                            description: "This is disabled checkbox"
                        }
                    }

                    Row {
                        spacing: 6
                        Switch {
                            text: "Switch"
                        }
                    }
                }
            }
            Card {
                id: inputTab
                Column {
                    spacing: 16
                    RowLayout {
                        spacing: 6

                        TextField {
                            placeholderText: "Enter your name"
                        }

                        TextField {
                            text: "This is disabled"
                            enabled: false
                            width: 200
                        }

                        TextField {
                            echoMode: TextInput.Password
                            text: "Password"
                            width: 200
                        }
                    }
                    RowLayout {
                        spacing: 6

                        TextField {
                            width: 200
                            Layout.fillWidth: true
                            placeholderText: "Your email"
                        }

                        Button {
                            id: btnSubscribe
                            type: "primary"
                            text: "Subscribe"
                        }
                    }
                    RowLayout {
                        spacing: 6

                        ComboBox {
                            model: ["Item 1", "Item 2", "Item 3"]
                        }
                    }
                }
            }
            Card {
                id: avatarTab
                Row {
                    spacing: 6

                    Avatar {
                        src: "https://i.pravatar.cc/150?img=70"
                        size: "lg"
                    }

                    Avatar {
                        src: "https://i.pravatar.cc/150?img=43"
                    }

                    Avatar {
                        src: "https://i.pravatar.cc/150?img=64"
                        size: "sm"
                    }
                }
            }
            Card {
                id: tableViewTab
                TableView {
                    id: mainTableView
                    anchors.fill: parent
                    model: myWatchlist
                    resizableColumns: true

                    delegate: Rectangle {
                        implicitHeight: 36
                        implicitWidth: 100

                        Text {
                            anchors.centerIn: parent
                            text: name
                        }
                    }
                }
            }
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
}
