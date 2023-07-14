import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

Button {
    id: control

    property string type: "default"
    property string size: "md"
    property bool loading: false

    readonly property var styles: LBTheme.btnStyle(control)
    readonly property var sizes: LBTheme.btnSize(control)

    leftPadding: sizes.padding
    rightPadding: sizes.padding
    activeFocusOnTab: true
    focusPolicy: Qt.StrongFocus

    readonly property var hasIcon: icon.source != ""

    enabled: !control.loading

    contentItem: Row {
        anchors.centerIn: parent
        spacing: 4
        opacity: enabled ? down ? 0.7 : 1.0 : 0.3

        Icon {
            id: icon
            source: control.icon.source
            size: sizes.iconSize
            visible: hasIcon
            color: styles.color
            opacity: enabled ? 1 : 0.3
        }

        Text {
            id: label
            text: control.text
            color: styles.color
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Loading {
            color: styles.color
            size: sizes.iconSize * 0.85
            visible: control.loading
            enabled: control.enabled
        }

        Transition {
            AnchorAnimation {
            }  //animates any AnchorChanges in the corresponding state change
        }
    }

    background: Rectangle {
        id: bg
        anchors.fill: parent
        // implicitWidth: sizes.width
        implicitHeight: sizes.height
        opacity: enabled ? 1 : 0.3
        color: styles.backgroundColor
        border.width: 1
        border.color: styles.borderColor
        radius: sizes.radius
        layer.enabled: down ? false : true
        layer.effect: Shadow {
            size: "sm"
        }
    }
}
