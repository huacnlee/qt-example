import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

DropShadow {
    id: control
    property string size: ""
    property var styles: LBTheme.shadowStyle(control)

    verticalOffset: styles.verticalOffset
    horizontalOffset: 0
    color: styles.color
    radius: styles.radius
}
