import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "theme.mjs" as LBTheme

Item {
    id: control
    property int size: 16
    property string name
    property string source
    property color color: LBTheme.colors.foreground
    anchors.verticalCenter: parent.verticalCenter

    readonly property string sourcePath: {
        if (source) {
            return source;
        }
        if (name.endsWith(".svg")) {
            return name;
        }
        if (!name) {
            return null;
        }
        return `assets/${name}.svg`;
    }

    width: size
    height: size

    Image {
        id: image
        anchors.verticalCenter: parent.verticalCenter

        source: sourcePath
        sourceSize.width: size
        sourceSize.height: size
        antialiasing: true
        fillMode: Image.PreserveAspectFit
        opacity: down ? 0.9 : 1
    }

    ColorOverlay {
        anchors.fill: image
        source: image
        color: control.color
    }
}
