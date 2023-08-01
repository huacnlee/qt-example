import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

GroupBox {
    id: control

    readonly property int radius: LBTheme.radius
    property color color: LBTheme.colors.background
    padding: 24
    clip: true

    background: Rectangle {
        y: control.topPadding - control.bottomPadding
        width: parent.width
        height: parent.height - control.topPadding + control.bottomPadding
        color: control.color
        border.color: LBTheme.colors.border
        radius: control.radius
    }

    label: Label {
        x: 8
        text: control.title
        color: LBTheme.colors.mutedForeground
        font.weight: Font.DemiBold
        elide: Text.ElideRight
    }
}
