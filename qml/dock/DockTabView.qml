import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml
import "../components"

DockBase {
    id: root
    contentItem: stockView
    topPadding: tabBar.height + 3
    objectName: "DockTabView"
    default property alias children: stockView.children // 声明的元素默认以myView为parent

    StackLayout {
        id: stockView
        z: 2
        objectName: "DockTabView.Data"
        currentIndex: tabBar.currentIndex
    }

    TabBar {
        id: tabBar
        z: 1
        objectName: "DockTabView.Bar"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 40
        spacing: 0
        Repeater {
            model: stockView.children
            TabButton {
                height: parent.height
                text: modelData.name
            }
        }
    }

    function switchToIndex(index) {
        tabBar.currentIndex = index;
    }
}
