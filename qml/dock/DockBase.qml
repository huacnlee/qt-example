import QtQuick
import QtQuick.Controls

Control {
    id: control
    property bool showDockArea: false
    property var state: DockBase.DockState.Float
    property color dockAreaBorderColor: "#e57e25"
    property color dockAreaColor: "#feeee1"
    property Component recvRec: Component {
        Rectangle {
            anchors.fill: parent
            anchors.margins: 2
            border.width: 2
            border.color: dockAreaBorderColor
            color: dockAreaColor
            opacity: 0.5
            visible: showDockArea
        }
    }

    enum DockState {
        Fill,
        Center,
        Top,
        Left,
        Right,
        Bottom,
        Float,
        Tab,
        Split,
        FillDock
    }

    states: [
        State {
            name: "Fill"
            when: state === DockBase.DockState.Fill || state === DockBase.DockState.Split || state === DockBase.DockState.FillDock
            AnchorChanges {
                target: control
                anchors.left: control.parent ? control.parent.left : undefined
                anchors.top: control.parent ? control.parent.top : undefined
                anchors.right: control.parent ? control.parent.right : undefined
                anchors.bottom: control.parent ? control.parent.bottom : undefined
            }
        },
        State {
            name: "Float"
            when: state === DockBase.DockState.Float || state === DockBase.DockState.Tab
            AnchorChanges {
                target: control
                anchors.left: undefined
                anchors.top: undefined
                anchors.right: undefined
                anchors.bottom: undefined
            }
        },
        State {
            name: "Left"
            when: state === DockBase.DockState.Left
            AnchorChanges {
                target: control
                anchors.left: control.parent.left
                anchors.top: control.parent.top
                anchors.right: undefined
                anchors.bottom: control.parent.bottom
            }
        },
        State {
            name: "Top"
            when: state === DockBase.DockState.Top
            AnchorChanges {
                target: control
                anchors.left: control.parent.left
                anchors.top: control.parent.top
                anchors.right: control.parent.right
                anchors.bottom: undefined
            }
        },
        State {
            name: "Right"
            when: state === DockBase.DockState.Right
            AnchorChanges {
                target: control
                anchors.left: undefined
                anchors.top: control.parent.top
                anchors.right: control.parent.right
                anchors.bottom: control.parent.bottom
            }
        },
        State {
            name: "Bottom"
            when: state === DockBase.DockState.Bottom
            AnchorChanges {
                target: control
                anchors.left: control.parent.left
                anchors.top: undefined
                anchors.right: control.parent.right
                anchors.bottom: control.parent.bottom
            }
        },
        State {
            name: "Center"
            when: state === DockBase.DockState.Center
            AnchorChanges {
                target: control
                anchors.verticalCenter: control.parent.verticalCenter
                anchors.horizontalCenter: control.parent.horizontalCenter
            }
        }
    ]

    DockBorder {
        control: control
        direction: {
            switch (state) {
            case DockBase.DockState.Fill:
            case DockBase.DockState.Tab:
            case DockBase.DockState.Split:
            case DockBase.DockState.FillDock:
                return DockBorder.Direction.None;
            case DockBase.DockState.Top:
                return DockBorder.Direction.Bottom;
            case DockBase.DockState.Left:
                return DockBorder.Direction.Right;
            case DockBase.DockState.Right:
                return DockBorder.Direction.Left;
            case DockBase.DockState.Bottom:
                return DockBorder.Direction.Top;
            case DockBase.DockState.Float:
            case DockBase.DockState.Center:
                return DockBorder.Direction.All;
            default:
                return DockBorder.Direction.All;
            }
        }
    }
}
