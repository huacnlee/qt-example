import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import "main.mjs" as MainJS
import "components"
import Qt.labs.qmlmodels
import QtExample 1.0

ColumnLayout {
    spacing: 12
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

        Button {
            type: "link"

            Icon {
                name: "info"
            }

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

    Row {
        spacing: 6

        Button {
            text: "ToolTip"

            ToolTip {
                text: "This is a tooltip have a long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long text."
            }
        }

        Button {
            text: "ToolTip in Short"

            ToolTip {
                text: "This is a tooltip."
            }
        }

        Button {
            text: "ToolTip with newline"

            ToolTip {
                text: "This is a tooltip.\nThis is second line in tooltip."
            }
        }
    }

    GroupBox {
        title: "Toast"

        Row {
            spacing: 6

            Button {
                text: "Info"
                onClicked: {
                    toast.info("This is info toast message.");
                }
            }

            Button {
                text: "Success"
                onClicked: {
                    toast.success("数据提交成功，感谢您的反馈。");
                }
            }

            Button {
                text: "Warning"
                onClicked: {
                    toast.warning({
                            "message": "您的网络不稳定，请稍后重试。",
                            "duration": 3000
                        });
                }
            }

            Button {
                text: "Error"
                onClicked: {
                    toast.error("Sorry, something went wrong.");
                }
            }

            Button {
                text: "Info with Action"
                onClicked: {
                    toast.info("This is info toast message.", closeAction);
                }
            }

            Button {
                id: closeAction
                text: "Dismiss"
            }
        }
    }
}
