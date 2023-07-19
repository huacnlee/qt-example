import Qt.labs.platform
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import "main.mjs" as MainJS
import "components"
import QtExample 1.0

Column {
    spacing: 16

    property var model: SimpleModel {
        id: model
        message: "Hello World"
    }

    ColumnLayout {
        spacing: 6

        Label {
            text: "Counter: " + model.counter
        }
        Label {
            text: "Message: " + model.message
        }
    }

    GroupBox {
        title: "Button Style"

        Row {
            spacing: 6

            Button {
                text: "Primary Button"
                type: "primary"
                onClicked: model.increment_number()
            }
            Button {
                text: "Delete"
                type: "danger"
                onClicked: model.message = "You have clicked the delete button."
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
    }

    Divider {
    }

    GroupBox {
        title: "Toggle Button"

        Row {
            spacing: 6

            Button {
                text: "Primary Toggle"
                type: "primary"
                checkable: true
                onClicked: model.message = "Primary Toggle Clicked: " + checked
            }
            Button {
                text: "Danger Toggle"
                type: "danger"
                checkable: true
                onClicked: model.message = "Danger Toggle Clicked: " + checked
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

    GroupBox {
        title: "Button Sizes"
        Row {
            spacing: 6

            Button {
                text: "Add"

                onClicked: model.sayHi(model.string, model.number)
            }
            Button {
                size: "lg"
                text: "This is a Large Button"

                onClicked: model.sayHi(model.string, model.number)
            }
            Button {
                size: "sm"
                text: "Small Button"

                onClicked: model.sayHi(model.string, model.number)
            }
            Button {
                enabled: false
                text: "Button Disabled"

                onClicked: model.sayHi(model.string, model.number)
            }
        }
    }

    GroupBox {
        title: "Button with Icon"
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
    }

    GroupBox {
        title: "Loading"

        Column {
            spacing: 12
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
    }
}
