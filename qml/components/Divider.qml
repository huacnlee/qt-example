import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

Rectangle {
    property string type: "horizontal"

    readonly property double lineMargin: 2

    color: LBTheme.colors.border
    x: type == "horizontal" ? lineMargin : 0
    y: type == "horizontal" ? 0 : lineMargin
    width: type == "horizontal" ? (parent.width - lineMargin * 2) : 1
    height: type == "horizontal" ? 1 : (parent.height - lineMargin * 2)
}
