import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import "theme.mjs" as LBTheme

SplitView {
    id: control

    handle: Rectangle {
        implicitWidth: 4
        implicitHeight: 4
        color: SplitHandle.hovered ? LBTheme.colors.focusRing : "transparent"
    }
}
