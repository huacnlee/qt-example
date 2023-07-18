import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

Rectangle {
    property string text
    property bool isHeader: false
    default property alias content: contentWrap.children
    property int padding: 8

    color: LBTheme.colors.background
    implicitWidth: 120
    implicitHeight: isHeader ? 40 : 48

    Item {
        anchors.fill: parent
        anchors.leftMargin: padding
        anchors.rightMargin: padding

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
