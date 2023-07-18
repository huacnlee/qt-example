import QtQuick
import QtQuick.Controls
import "theme.mjs" as LBTheme

Control {
    id: control

    property int duration: 650
    property var easing: Easing.BezierSpline
    property real progress: 0.25
    property bool indeterminate: true
    property string size: "sm"
    property string color: LBTheme.colors.primary
    anchors.verticalCenter: parent.verticalCenter

    width: sizeValue
    height: sizeValue
    opacity: 0.7

    readonly property real radius: width / 2
    readonly property var sizeValue: size == "sm" ? 16 : size == "md" ? 24 : size == "lg" ? 32 : 16
    readonly property real linWidth: sizeValue * 0.1
    readonly property real radius2: radius * 0.75

    Rectangle {
        id: indicator
        anchors.fill: parent

        radius: radius
        border.width: linWidth
        color: "transparent"
        border.color: color

        Behavior on rotation  {
            id: indicatorBehavior
            enabled: false
            NumberAnimation {
                duration: control.duration
                easing.type: control.easing
                onRunningChanged: {
                    if (!running) {
                        indicatorBehavior.enabled = false;
                        indicator.rotation = 0;
                        indicatorBehavior.enabled = true;
                        indicator.rotation = 360;
                    }
                }
            }
        }

        Canvas {
            id: canvas
            anchors.fill: parent
            antialiasing: true
            renderTarget: Canvas.Image
            onPaint: {
                var ctx = canvas.getContext("2d");
                ctx.setTransform(1, 0, 0, 1, 0, 0);
                ctx.clearRect(0, 0, canvas.width, canvas.height);
                ctx.save();
                ctx.lineWidth = control.linWidth;
                ctx.strokeStyle = control.color;
                ctx.fillStyle = control.color;
                ctx.beginPath();
                ctx.arc(width / 2, height / 2, radius2, -0.5 * Math.PI, -0.5 * Math.PI + progress * 3 * Math.PI);
                ctx.stroke();
                ctx.closePath();
                ctx.restore();
            }
        }
    }

    onProgressChanged: {
        canvas.requestPaint();
    }
    Component.onCompleted: {
        if (indeterminate) {
            indicatorBehavior.enabled = true;
            indicator.rotation = 360;
        }
    }
}
