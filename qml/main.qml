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
    width: 1280
    height: 960
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
            currentIndex: 3

            Repeater {
                model: ["Button", "CheckBox", "Text", "Dialog", "Popover", "Avatar", "Table"]
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
                    Row {
                        spacing: 6
                        Button {
                            type: "primary"
                            text: "Icon Primary"
                            icon.source: "assets/mail-send.svg"
                        }
                        Button {
                            type: "danger"
                            text: "Delete"
                            icon.source: "assets/trash.svg"
                        }
                        Button {
                            text: "Icon Button"
                            icon.source: "assets/arrow-down.svg"
                        }

                        Button {
                            size: "sm"
                            text: "Small Button"
                            icon.source: "assets/checkbox-check.svg"
                        }

                        Button {
                            size: "lg"
                            text: "Large Button"
                            icon.source: "assets/trash.svg"
                        }
                    }
                    Row {
                        spacing: 6

                        Button {
                            text: "Primary with Loading"
                            type: "primary"
                            loading: true
                        }

                        Button {
                            text: "Danger with Loading"
                            type: "danger"
                            loading: true
                        }

                        Button {
                            text: "Default"
                            loading: true
                        }

                        Button {
                            text: "Disabled"
                            enabled: false
                            loading: true
                        }

                        Button {
                            text: "Icon with Loading"
                            loading: true
                            icon.source: "assets/mail-send.svg"
                        }

                        Button {
                            text: "Small Loading"
                            size: "sm"
                            loading: true
                        }

                        Button {
                            text: "Large Loading"
                            size: "lg"
                            loading: true
                        }
                    }
                    Column {
                        spacing: 6

                        Label {
                            text: "Link Button"
                        }

                        Row {
                            spacing: 6

                            Link {
                                text: "点击这里"
                            }

                            Link {
                                text: "Link Disabled"
                                enabled: false
                            }

                            Link {
                                text: "Link with Icon"
                                icon.source: "assets/arrow-down.svg"
                            }
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

                        Switch {
                            text: "Switch Checked"
                            checked: true
                        }

                        Switch {
                            text: "Switch Disabled"
                            enabled: false
                        }

                        Switch {
                            text: "Switch Checked (Disabled)"
                            enabled: false
                            checked: true
                        }
                    }
                }
            }
            Card {
                id: textTab
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

                        ComboBox {
                            model: ["中国大陆", "香港", "美国", "新加坡", "澳大利亚", "新西兰", "印度", "英国", "德国", "日本", "韩国", "泰国", "马来西亚", "菲律宾", "印度尼西亚", "加拿大", "法国", "意大利", "俄罗斯", "西班牙", "瑞典", "爱尔兰", "荷兰", "瑞士", "巴西", "阿根廷", "南非", "埃及", "其他"]
                            currentIndex: 3
                        }

                        ComboBox {
                            model: ["This is disabled", "Item 2"]
                            enabled: false
                        }
                    }

                    RowLayout {
                        spacing: 6

                        Badge {
                            type: "primary"
                            text: "Badge"
                        }

                        Badge {
                            text: "Outline"
                        }

                        Badge {
                            type: "danger"
                            text: "Danger"
                        }
                    }
                }
            }
            Card {
                id: dialogTab

                Row {
                    spacing: 6

                    Button {
                        text: "Open Dialog"
                        onClicked: () => {
                            dialog1.modal = false;
                            dialog1.open();
                        }

                        Dialog {
                            id: dialog1
                            title: "Dialog Title"

                            Column {
                                spacing: 10
                                Text {
                                    text: "This is dialog content."
                                }

                                TextField {
                                    placeholderText: "Enter your name"
                                }
                            }

                            standardButtons: Dialog.Ok | Dialog.Cancel
                            onAccepted: () => {
                                console.log("Accepted");
                            }
                            onRejected: console.log("Cancel clicked")
                        }
                    }

                    Button {
                        text: "Open Modal"
                        onClicked: () => {
                            dialog1.modal = true;
                            dialog1.open();
                        }
                    }
                }
            }
            Card {
                id: popoverTab
                Row {
                    spacing: 6

                    Button {
                        text: "Hover Popover"

                        Popover {
                            trigger: "both"
                            showClose: false

                            Column {
                                Row {
                                    Text {
                                        text: "This is popover text.\nThis is second line text."
                                    }

                                    Link {
                                        text: "Dismiss"
                                        onClicked: () => {
                                            parent.close();
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Button {
                        text: "Click Popover"
                        Popover {
                            trigger: "click"
                            Column {
                                spacing: 6
                                Text {
                                    text: "This is popover text."
                                }
                            }
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
