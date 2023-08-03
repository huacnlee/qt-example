import QtQuick
import QtQuick.Controls.Basic
import "theme.mjs" as LBTheme

Item {
    id: control
    property var root
    property int layoutY: 75

    Item {
        id: toastControl
        property int maxWidth: 300
        property var screenLayout: null
        property var type: "info"
        property var style: LBTheme.toastStyles.info

        function initScreenLayout() {
            if (screenLayout == null) {
                screenLayout = screenlayoutComponent.createObject(root);
                screenLayout.y = control.layoutY;
                screenLayout.z = 100000;
            }
        }

        function showToast(options) {
            const { 
                title,
                description,
                message,
                type = "info",
                duration = 1000,
                action
            } = options;
            
            if (!screenLayout) {
                initScreenLayout();
            } else {
                let last = screenLayout.getLastloader();
                if (last?.type === type && last?.text === message) {
                    last.restart();
                    return;
                }
            }
            toastControl.style = LBTheme.toastStyles[type] || LBTheme.toastStyles.info;
            toastControl.type = type
            if (action) {
                toastControl.action = action;
            }
            contentComponent.createObject(screenLayout, {
                    "type": type,
                    "text": message,
                    "duration": duration
                });
        }

        Component {
            id: screenlayoutComponent
            Column {
                spacing: 12
                width: parent.width
               
                onChildrenChanged: {
                    if (children.length === 0) {
                        destroy();
                    }
                }

                function getLastloader() {
                    if (children.length > 0) {
                        return children[children.length - 1];
                    }
                    return null;
                }
            }
        }
        Component {
            id: contentComponent
            Item {
                id: content
                property int duration: 1500
                property var itemcomponent
                property string type
                property string text
                property string moremsg
                width: parent.width
                height: loader.height

                function close() {
                    content.destroy();
                }
                function restart() {
                    delayTimer.restart();
                }

                Timer {
                    id: delayTimer
                    interval: duration
                    running: true
                    repeat: true
                    onTriggered: content.close()
                }

                Loader {
                    id: loader
                    x: (parent.width - width) / 2
                    y: item ? -10 : 0
                    property var _super: content
                    opacity: item ? 1 : 0.5
                    scale: item ? 1 : 0.9
                    asynchronous: true

                    Behavior on opacity  {
                        NumberAnimation {
                            duration: 50
                        }
                    }

                    Behavior on y  {
                        NumberAnimation {
                            duration: 150
                        }
                    }

                    Behavior on scale  {
                        NumberAnimation {
                            duration: 50
                        }
                    }

                    sourceComponent: itemcomponent ? itemcomponent : toastControl.background
                }
            }
        }
        property Component background: Rectangle {
            width: rowlayout.width + 80
            height: rowlayout.height + 20
            color: toastControl.style.background
            radius: LBTheme.radius
            border.width: 1
            border.color: toastControl.style.border

            property var action: actionWrap.children

            Row {
                id: rowlayout
                x: 20
                y: (parent.height - height) / 2
                spacing: 10

                Label {
                    text: _super.text
                    wrapMode: Text.WrapAnywhere
                    color: toastControl.style.foreground
                    width: Math.min(implicitWidth, toastControl.maxWidth)
                }

                Item {
                    id: actionWrap
                }
            }

            layer.enabled: true
            layer.effect: Shadow {
            }
        }
    }

    function formatOptions(options, type) {
        if (typeof options === 'string') {
            options = {
                message: options
            }
        }
        options.type = type;
        return options
    }

    function info(options) {
        options = formatOptions(options, "info")
        return toastControl.showToast(options);
    }

    function success(options) {
        options = formatOptions(options, "success")
        return toastControl.showToast(options);
    }

    function warning(options) {
        options = formatOptions(options, "warning")
        return toastControl.showToast(options);
    }

    function error(options) {
        options = formatOptions(options, "error")
        return toastControl.showToast(options);
    }
}
