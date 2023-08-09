import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import "theme.mjs" as LBTheme

SplitView {
    id: control

    handle: Rectangle {
        id: handle
        implicitWidth: 10
        implicitHeight: 10
        color: "transparent"

        readonly property bool hovered: SplitHandle.hovered

        Rectangle {
            anchors.fill: parent
            anchors.margins: 2.5
            implicitWidth: 5
            implicitHeight: 5
            radius: LBTheme.borderRadius.sm
            opacity: 0.8
            color: handle.hovered ? LBTheme.colors.selectionBackground : "transparent"
        }

        Control {
            anchors.centerIn: parent

            Rectangle {
                anchors.fill: parent
                color: LBTheme.colors.background
            }

            Icon {
                anchors.centerIn: parent
                name: "draggable"
                size: 10
                opacity: handle.hovered ? 0.6 : 0.2
                // transformOrigin: control.orientation === Qt.Horizontal ? Qt.Top : Qt.Left
                rotation: control.orientation === Qt.Horizontal ? 0 : 90
            }
        }
    }
}
