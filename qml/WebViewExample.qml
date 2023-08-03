import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtWebEngine
import "main.mjs" as MainJS
import "components"
import QtExample 1.0

ColumnLayout {
    anchors.fill: parent
    spacing: 12

    ObjectModel {
        id: model

        property bool loading: false
    }

    Component.onCompleted: {
        webview.url = "https://github.com/explore";
    }

    RowLayout {
        spacing: 6

        Button {
            text: "Back"
            enabled: webview.canGoBack
            onClicked: {
                webview.goBack();
            }
        }

        TextField {
            id: urlField
            Layout.fillWidth: true
            enabled: !model.loading
            text: "https://github.com/explore"
            placeholderText: "Enter URL"
        }

        Button {
            text: "Go"
            type: "primary"
            loading: model.loading
            onClicked: {
                webview.url = urlField.text;
            }
        }
    }

    Frame {
        Layout.fillWidth: true
        Layout.fillHeight: true
        padding: 0
        clip: true
        WebEngineView {
            id: webview
            anchors.fill: parent
            onLoadingChanged: {
                model.loading = loading;
            }
        }
    }
}
