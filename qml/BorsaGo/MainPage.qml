import QtQuick 1.1
import com.nokia.meego 1.0
import com.nokia.extras 1.0

Page {
    tools: commonTools
    property string hsAdi: ""
    property string sUrl: "http://www.apps-dev.com/repository/borsago/hisseler.asp"

    Component.onCompleted:  {theme.inverted = true}

    BusyIndicator {
        id: indicator
        anchors.centerIn: parent
        platformStyle: BusyIndicatorStyle { size: "large" }
        running:  true
        visible: true
    }

    XmlListModel {
        id: xmlModel
        source: sUrl
        query: "/rss/hissefield/item"

        XmlRole { name: "hisseadi"; query: "hisseadi/string()" }
        XmlRole { name: "hisseharf"; query: "hisseharf/string()" }

        onStatusChanged: {
            if (status == XmlListModel.Ready) {
                for (var i=0; i<count; i++) {
                    var item = xmlModel.get(i)
                    hisseModel.append({"title": item.hisseadi,"harf": item.hisseharf,"subtitle": item.hisseadi + " hisse senedine ait detaylar."})
                }
                indicator.visible = false
                indicator.running = false
                searchRect.visible = true
                listView.visible = true
            } else if (status == XmlListModel.Loading) {
                indicator.running = true
                indicator.visible = true
                searchRect.visible = false
                listView.visible = false
            }
        }
    }

    ListModel {
        id: hisseModel
    }

    Rectangle {
        id: searchRect
        width: parent.width
        height: 70
        color: "black"
        z: 12

        Item {
            id: araItem
            width: parent.width
            height: 70

            TextField {
                id: searchField
                anchors.fill: parent
                anchors.margins: 5
                focus: false
                placeholderText: "Ara"
                inputMethodHints: Qt.ImhNoPredictiveText

                Keys.onPressed: {
                    if (event.key == 16777220) {
                        hisseModel.clear()
                        if (searchField.text != "") {
                            xmlModel.source = sUrl + "?ara=" + searchField.text
                            homeTus.visible = true
                        } else {
                            xmlModel.source = sUrl
                            homeTus.visible = false
                        }
                        xmlModel.reload()
                    }
                }

                ToolIcon {
                    id: searchIcon
                    iconId: "toolbar-search";
                    anchors.verticalCenter: searchField.verticalCenter
                    anchors.right: searchField.right
                    onClicked: {
                        hisseModel.clear()
                        if (searchField.text != "") {
                            xmlModel.source = sUrl + "?ara=" + searchField.text
                            homeTus.visible = true
                        } else {
                            xmlModel.source = sUrl
                            homeTus.visible = false
                        }
                        xmlModel.reload()
                    }
                }
            }
        }
    }

    ListView {
        id: listView
        y: 70
        height: (parent.height-searchRect.height)
        width: parent.width
        model: hisseModel
        section.property: "harf"

        delegate: ListDelegate {
            Image {
                id: arrowImage
                source: "image://theme/icon-m-common-drilldown-arrow"
                        + (theme.inverted ? "-inverse" : "")
                anchors { right: parent.right; verticalCenter: parent.verticalCenter }
            }

            onClicked: {
                mainPage.hsAdi = title
                pageStack.push(Qt.resolvedUrl("HisseSenet.qml"))
            }
        }
    }

    SectionScroller {
        y: 70
        listView: listView
    }

    ToolBarLayout {
        id: commonTools
        visible: true
        ToolIcon {
            id: homeTus
            platformIconId: "toolbar-home"
            anchors.left: (parent === undefined) ? undefined : parent.left
            visible: false
            onClicked: {
                searchField.text = ""
                hisseModel.clear()
                xmlModel.source = sUrl
                homeTus.visible = false
                xmlModel.reload()
            }
        }
        ToolIcon {
            platformIconId: "toolbar-view-menu"
            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: (myMenu.status == DialogStatus.Closed) ? myMenu.open() : myMenu.close()
        }
    }
}
