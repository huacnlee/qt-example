import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

Image {
    id: control
    property int size: 16
    required property string name
    anchors.verticalCenter: parent.verticalCenter
    width: size
    height: size

    property string sourcePath: {
        if (name.endsWith(".svg")) {
            return name;
        }
        return `assets/${name}.svg`;
    }

    source: sourcePath
    sourceSize.width: size
    sourceSize.height: size
    fillMode: Image.PreserveAspectFit
    opacity: down ? 0.9 : 1
}
