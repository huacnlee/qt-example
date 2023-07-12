import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

DropShadow {
    id: control
    property string size: "md"
    property var style: LBTheme.shadowStyle(control)

    verticalOffset: 1
    horizontalOffset: 0
    color: style.color
    radius: style.radius
}
