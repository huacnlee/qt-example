import Qt.labs.platform
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import "main.mjs" as MainJS
import "LBLight"
import com.company.example 1.0

Column {
    spacing: 16

    property var myObject: MyObject {
        id: myObject
    }

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
            text: "Primary Button"
            type: "primary"
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

    Divider {
    }

    Column {
        spacing: 12

        Text {
            text: "Button Toggle"
            font.pixelSize: 16
            font.weight: Font.DemiBold
        }

        Row {
            spacing: 6

            Button {
                text: "Primary Toggle"
                type: "primary"
                checkable: true
            }
            Button {
                text: "Danger Toggle"
                type: "danger"
                checkable: true
            }
            Button {
                enabled: false
                text: "Disabled Toggle"
                type: "primary"
                checkable: true
            }
            Button {
                enabled: false
                text: "Disabled Danger Toggle"
                type: "danger"
                checkable: true

                onClicked: {
                    reloadData();
                }
            }

            Divider {
                type: "vertical"
            }

            Button {
                text: "Large Toggle"
                size: "lg"
                checkable: true
                checked: false
            }
            Button {
                text: "Small Toggle"
                size: "sm"
                checkable: true
                checked: true
            }
            Button {
                text: "Link Toggle"
                size: "sm"
                type: "link"
                checkable: true
            }
        }
    }

    Row {
        spacing: 6

        Button {
            text: "Add"

            onClicked: myObject.sayHi(myObject.string, myObject.number)
        }
        Button {
            size: "lg"
            text: "This is a Large Button"

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
            text: "Primary (Click to Loading)"
            type: "primary"
            onClicked: {
                loading = true;
                timer.setTimeout(1500, () => {
                        loading = false;
                    });
            }
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
