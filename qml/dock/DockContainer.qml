import QtQuick
import QtQuick.Controls

DockBase {
    id: control
    anchors.margins: 2
    showDockArea: childShowDockArea | dropRec.containsDrag
    state: DockBase.DockState.Fill
    property var item: myView
    property bool childShowDockArea: false

    DockBase {
        id: myView
        anchors.fill: parent
        objectName: "DockContainerContent"
        state: DockBase.DockState.Fill
    }

    Rectangle {
        id: dropRec
        z: 9999
        anchors.fill: parent
        anchors.margins: 25
        color: "transparent"
        property bool containsDrag: leftDockReceive.containsDrag | rightDockReceive.containsDrag | topDockReceive.containsDrag | bottomDockReceive.containsDrag

        DropArea {
            id: leftDockReceive
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 40
            height: parent.height * 0.3
            Loader {
                anchors.fill: parent
                sourceComponent: recvRec
            }
            onDropped: function (drop) {
                dockLeftBy(drop.source);
            }
        }
        DropArea {
            id: rightDockReceive
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: 40
            height: parent.height * 0.3
            z: 10000
            Loader {
                anchors.fill: parent
                sourceComponent: recvRec
            }
            onDropped: function (drop) {
                dockRightBy(drop.source);
            }
        }
        DropArea {
            id: topDockReceive
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.3
            height: 40
            z: 10000
            Loader {
                anchors.fill: parent
                sourceComponent: recvRec
            }
            onDropped: function (drop) {
                dockTopBy(drop.source);
            }
        }
        DropArea {
            id: bottomDockReceive
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.3
            height: 40
            z: 10000
            Loader {
                anchors.fill: parent
                sourceComponent: recvRec
            }

            onDropped: function (drop) {
                dockBottomBy(drop.source);
            }
        }
    }
    function dockLeftBy(it) {
        let source = item;
        let myParent = source.parent;
        let split = Qt.createComponent("DockSplit.qml").createObject(myParent, {
                "state": DockBase.DockState.Fill,
                "orientation": Qt.Horizontal
            });
        let preWidth = source.width / (source.width + it.width);
        split.item1.SplitView.preferredWidth = preWidth * it.width;
        split.item2.SplitView.preferredWidth = preWidth * source.width;
        source.state = it.state = DockBase.DockState.Split;
        source.parent = split.item2;
        it.parent = split.item1;
        item = split;
    }

    function dockRightBy(it) {
        let source = item;
        let myParent = source.parent;
        let split = Qt.createComponent("DockSplit.qml").createObject(myParent, {
                "state": DockBase.DockState.Fill,
                "orientation": Qt.Horizontal
            });
        let preWidth = source.width / (source.width + it.width);
        split.item2.SplitView.preferredWidth = preWidth * it.width;
        split.item1.SplitView.preferredWidth = preWidth * source.width;
        source.state = it.state = DockBase.DockState.Split;
        source.parent = split.item1;
        it.parent = split.item2;
        item = split;
    }

    function dockTopBy(it) {
        let source = item;
        let myParent = source.parent;
        let split = Qt.createComponent("DockSplit.qml").createObject(myParent, {
                "state": DockBase.DockState.Fill,
                "orientation": Qt.Vertical
            });
        let preHeight = source.height / (source.height + it.height);
        split.item1.SplitView.preferredHeight = preHeight * it.height;
        split.item2.SplitView.preferredHeight = preHeight * source.height;
        source.state = it.state = DockBase.DockState.Split;
        source.parent = split.item2;
        it.parent = split.item1;
        item = split;
    }

    function dockBottomBy(it) {
        let source = item;
        let myParent = source.parent;
        let split = Qt.createComponent("DockSplit.qml").createObject(myParent, {
                "state": DockBase.DockState.Fill,
                "orientation": Qt.Vertical
            });
        let preHeight = source.height / (source.height + it.height);
        split.item2.SplitView.preferredHeight = preHeight * it.height;
        split.item1.SplitView.preferredHeight = preHeight * source.height;
        source.state = it.state = DockBase.DockState.Split;
        source.parent = split.item1;
        it.parent = split.item2;
        item = split;
    }
}
