import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

Rectangle {
    id: control
    property string text
    property bool isHeader: false
    property bool selected: false
    default property alias content: contentWrap.children
    property int padding: 8

    // implicitWidth: 120
    implicitHeight: isHeader ? 40 : 48

    Rectangle {
        anchors.fill: parent
        color: control.selected ? LBTheme.colors.selectionBackground : "transparent"

        Rectangle {
            anchors.fill: parent
            anchors.leftMargin: control.padding
            anchors.rightMargin: control.padding
            color: "transparent"

            Item {
                id: contentWrap
                anchors.fill: parent
                visible: contentWrap.children.length > 0
            }

            Label {
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                text: text
                color: LBTheme.colors.foreground
                visible: contentWrap.children.length === 0
            }
        }
    }

    // Border bottom
    Rectangle {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: 1
        opacity: 0.8
        color: LBTheme.colors.border
    }
}
