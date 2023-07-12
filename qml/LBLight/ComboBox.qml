import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

ComboBox {
    id: control
    rightPadding: sizes.padding
    leftPadding: sizes.padding
    focusPolicy: Qt.StrongFocus
    property var size: "md"
    property var sizes: LBTheme.btnSize(control)

    property int popupOffset: 4

    delegate: ItemDelegate {
        id: itemDelegate
        implicitWidth: parent?.width || 0
        height: 32

        Rectangle {
            anchors.fill: parent
            color: itemDelegate.highlighted ? LBTheme.colors.accent : "transparent"
            radius: LBTheme.borderRadius.sm

            Icon {
                name: "checkbox-check"
                size: 14
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: control.rightPadding - 2
                visible: itemDelegate.selected
            }
        }

        contentItem: Text {
            text: control.textRole ? (Array.isArray(control.model) ? modelData[control.textRole] : model[control.textRole]) : modelData
            color: LBTheme.colors.foreground
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
        highlighted: control.highlightedIndex === index
        property var selected: control.currentIndex === index
    }

    indicator: Rectangle {
        id: canvas
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: control.rightPadding
        width: 16
        height: 16
        color: "transparent"
        Icon {
            size: 16
            name: "combobox-down"
            opacity: 0.5
        }
    }

    contentItem: Text {
        id: item
        leftPadding: 0
        rightPadding: control.indicator.width + control.spacing
        text: control.displayText
        font: control.font
        color: LBTheme.colors.foreground
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        id: bg
        implicitWidth: LBTheme.inputDefaultWidth
        implicitHeight: sizes.height
        border.color: LBTheme.colors.border
        color: hovered ? LBTheme.colors.accent : LBTheme.colors.background
        border.width: 1
        radius: LBTheme.radius
        layer.enabled: true
        layer.effect: Shadow {
            size: "sm"
        }
    }

    popup: Popup {
        id: dropdownMenu
        y: control.height + popupOffset
        width: control.width
        implicitHeight: contentItem.implicitHeight + 6
        verticalPadding: 3
        horizontalPadding: 3

        contentItem: ListView {
            id: listView
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null

            ScrollIndicator.vertical: ScrollIndicator {
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
                from: control.height - popupOffset
                to: control.height + popupOffset
                duration: 150
            }
            NumberAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 150
            }
        }
        exit: Transition {
            PropertyAnimation {
                properties: "scale"
                from: 1
                to: 0.95
                duration: 150
            }
            PropertyAnimation {
                properties: "y"
                from: control.height + popupOffset
                to: control.height - popupOffset
                duration: 150
            }
            NumberAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 150
            }
        }

        background: Rectangle {
            border.color: LBTheme.colors.border
            radius: LBTheme.radius

            layer.enabled: true
            layer.effect: Shadow {
                size: 'md'
            }
        }
    }
}
