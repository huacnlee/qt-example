import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects

ComboBox {
    id: control
    rightPadding: 16
    leftPadding: 16
    focusPolicy: Qt.StrongFocus

    delegate: ItemDelegate {
        width: control.width
        contentItem: Text {
            text: control.textRole ? (Array.isArray(control.model) ? modelData[control.textRole] : model[control.textRole]) : modelData
            color: "#18181B"
            font: control.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
        highlighted: control.highlightedIndex === index
    }

    indicator: Rectangle {
        id: canvas
        x: control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        width: 16
        height: 16
        Image {
            id: down_arrow
            width: 16
            height: 16
            source: "assets/combox-down.svg"
            sourceSize.width: 16
            sourceSize.height: 16
        }
        ColorOverlay {
            anchors.fill: down_arrow
            source: down_arrow
            color: "#18181B"
            transform: rotation
        }
    }

    contentItem: Text {
        leftPadding: 0
        rightPadding: control.indicator.width + control.spacing

        text: control.displayText
        font: control.font
        color: "#18181B"
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        id: bg
        implicitWidth: 120
        implicitHeight: 36
        border.color: "#E4E4E7"
        color: hovered ? "#F4F4F5" : "#FFFFFF"
        border.width: 1
        radius: 6
        layer.enabled: true
        layer.effect: Shadow {
            size: "sm"
        }
    }

    popup: Popup {
        y: control.height - 1
        width: control.width
        implicitHeight: contentItem.implicitHeight
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex

            ScrollIndicator.vertical: ScrollIndicator {
            }
        }

        enter: Transition {
            NumberAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 83
            }
        }
        exit: Transition {
            NumberAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 83
            }
        }

        background: Rectangle {
            border.color: "#18181B"
            radius: 6

            Shadow {
                size: "sm"
            }
        }
    }
}
