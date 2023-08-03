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
            anchors.margins: 4.5
            implicitWidth: 1
            implicitHeight: 1
            color: handle.hovered ? LBTheme.colors.focusRing : "transparent"
        }
    }
}
