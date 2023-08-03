import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

Button {
    id: control
    padding: 2
    anchors.margins: 0
    activeFocusOnTab: true
    focusPolicy: Qt.StrongFocus
    readonly property var textOpacity: enabled ? (down ? 0.7 : 1.0) : 0.3
    readonly property var hasIcon: icon.source != ""

    background: null
    contentItem: Row {
        id: row
        anchors.centerIn: parent
        spacing: 2
        opacity: enabled ? down ? 0.7 : 1.0 : 0.3

        Icon {
            id: icon
            source: control.icon.source
            width: 14
            height: 14
            visible: hasIcon
            opacity: enabled ? 1 : 0.3
        }
        Text {
            id: label
            text: control.text
            opacity: textOpacity
            color: LBTheme.colors.primary
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            HoverHandler {
                cursorShape: Qt.PointingHandCursor
            }
        }
    }

    // Hover underline
    Rectangle {
        id: hoverUnderline
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            bottomMargin: -1
            leftMargin: 1
            rightMargin: 1
        }

        height: 1
        opacity: textOpacity
        color: LBTheme.colors.primary
        visible: hovered && enabled
    }
}
