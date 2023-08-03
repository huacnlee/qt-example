import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Templates as T
import "theme.mjs" as LBTheme

ToolTip {
    id: control
    x: parent ? (parent.width - implicitWidth) / 2 : 0
    y: parent ? parent.height + margins : 0
    visible: parent ? parent.hovered : false

    readonly property int popupOffset: 6
    readonly property int maxWidth: 450
    implicitWidth: Math.min(maxWidth, Math.max(implicitBackgroundWidth + leftInset + rightInset, contentWidth + leftPadding + rightPadding))
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, contentHeight + topPadding + bottomPadding)

    margins: popupOffset
    padding: 6
    delay: 500

    closePolicy: T.Popup.CloseOnEscape | T.Popup.CloseOnPressOutsideParent | T.Popup.CloseOnReleaseOutsideParent
    contentItem: Text {
        text: control.text
        font: control.font
        color: LBTheme.colors.tooltipForeground
        wrapMode: Text.Wrap
    }
    background: Rectangle {
        color: LBTheme.colors.tooltip
        radius: LBTheme.borderRadius.sm

        Shadow {
            size: "sm"
        }
    }

    enter: Transition {
        PropertyAnimation {
            properties: "scale"
            from: 0.95
            to: 1
            duration: 150
        }
        PropertyAnimation {
            properties: "y"
            from: parent.height - popupOffset
            to: parent.height + popupOffset
            duration: 150
        }
        NumberAnimation {
            property: "opacity"
            from: 0
            to: 1
            duration: 80
        }
    }
}
