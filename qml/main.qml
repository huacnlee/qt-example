import FluentUI
import Qt.labs.platform
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

// This must match the qml_uri and qml_version
// specified with the #[cxx_qt::qobject] macro in Rust.
import com.company.example 1.0

Window {
    id: app
    title: qsTr("QT Example")
    visible: true
    width: 1000
    height: 640

    Component.onCompleted: {
        FluApp.init(app);
        FluTheme.darkMode = FluDarkMode.Light;
        FluApp.run();
        loadData(1, 10000);
    }

    function loadData(page, count) {
        var numbers = [100, 300, 500, 1000];
        function getRandomAge() {
            var randomIndex = Math.floor(Math.random() * numbers.length);
            return numbers[randomIndex];
        }
        var names = ["孙悟空", "猪八戒", "沙和尚", "唐僧", "白骨夫人", "金角大王", "熊山君", "黄风怪", "银角大王"];
        function getRandomName() {
            var randomIndex = Math.floor(Math.random() * names.length);
            return names[randomIndex];
        }
        var nicknames = ["复海大圣", "混天大圣", "移山大圣", "通风大圣", "驱神大圣", "齐天大圣", "平天大圣"];
        function getRandomNickname() {
            var randomIndex = Math.floor(Math.random() * nicknames.length);
            return nicknames[randomIndex];
        }
        var addresses = ["傲来国界花果山水帘洞", "傲来国界坎源山脏水洞", "大唐国界黑风山黑风洞", "大唐国界黄风岭黄风洞", "大唐国界骷髅山白骨洞", "宝象国界碗子山波月洞", "宝象国界平顶山莲花洞", "宝象国界压龙山压龙洞", "乌鸡国界号山枯松涧火云洞", "乌鸡国界衡阳峪黑水河河神府"];
        function getRandomAddresses() {
            var randomIndex = Math.floor(Math.random() * addresses.length);
            return addresses[randomIndex];
        }
        const dataSource = [];
        for (var i = 0; i < count; i++) {
            dataSource.push({
                    "name": getRandomName(),
                    "age": getRandomAge(),
                    "address": getRandomAddresses(),
                    "nickname": getRandomNickname(),
                    "height": 40,
                    "minimumHeight": 40,
                    "maximumHeight": 200
                    // action:com_action
                });
        }
        mainTableView.dataSource = dataSource;
    }

    onClosing: {
        closeDialog.open();
        return false;
    }

    FluContentDialog {
        id: closeDialog
        title: "Exit"
        message: "Are you sure to exit app?"
        negativeText: "Minimalize"
        buttonFlags: FluContentDialog.NeutralButton | FluContentDialog.NegativeButton | FluContentDialog.PositiveButton
        onNegativeClicked: {
            window.hide();
        }
        positiveText: "Exit"
        neutralText: "Cancel"
        blurSource: app
        onPositiveClicked: {
            window.deleteWindow();
            FluApp.closeApp();
        }
    }

    MyObject {
        id: myObject
        number: 1
        string: "My String with my number: " + myObject.number
    }

    Column {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Label {
            text: "Number: " + myObject.number
        }

        Label {
            text: "String: " + myObject.string
        }

        FluText {
            text: "You Name:"
            onTextChanged: myObject.string = text
        }

        Row {
            spacing: 6
            FluButton {
                text: "Increment Number"

                onClicked: myObject.incrementNumber()
            }

            FluButton {
                text: "Say Hi!"

                onClicked: myObject.sayHi(myObject.string, myObject.number)
            }
        }

        FluTableView {
            id: mainTableView
            anchors.fill: parent
            anchors.topMargin: 100
            columnSource: [{
                    "title": '姓名',
                    "dataIndex": 'name',
                    "width": 100,
                    "minimumWidth": 80,
                    "maximumWidth": 200,
                    "readOnly": true
                }, {
                    "title": '年龄',
                    "dataIndex": 'age',
                    "width": 100,
                    "minimumWidth": 100,
                    "maximumWidth": 100,
                    "readOnly": true
                }, {
                    "title": '住址',
                    "dataIndex": 'address',
                    "width": 200,
                    "minimumWidth": 100,
                    "readOnly": true
                }, {
                    "title": '别名',
                    "dataIndex": 'nickname',
                    "width": 100,
                    "minimumWidth": 80,
                    "maximumWidth": 200,
                    "readOnly": true
                }, {
                    "title": '操作',
                    "dataIndex": 'action',
                    "width": 160,
                    "minimumWidth": 160,
                    "maximumWidth": 160,
                    "readOnly": true
                }]
        }
    }
}
