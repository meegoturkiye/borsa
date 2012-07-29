import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    tools: commonTools
    orientationLock: PageOrientation.LockPortrait

    BusyIndicator {
        id: indicator
        anchors.centerIn: parent
        platformStyle: BusyIndicatorStyle { size: "large" }
        running:  true
        visible: true
    }

    XmlListModel {
        id: xmlModel
        source: "http://apps-dev.com/repository/borsago/hisse_detay.asp?hisse=" + mainPage.hsAdi
        query: "/rss/hissefield/item"

        XmlRole { name: "h_adi"; query: "h_adi/string()" }
        XmlRole { name: "h_alis"; query: "h_alis/string()" }
        XmlRole { name: "h_satis"; query: "h_satis/string()" }
        XmlRole { name: "h_imiktar"; query: "h_imiktar/string()" }
        XmlRole { name: "h_ihacim"; query: "h_ihacim/string()" }
        XmlRole { name: "h_ndeg"; query: "h_ndeg/string()" }
        XmlRole { name: "h_deg"; query: "h_deg/string()" }
        XmlRole { name: "h_1ac"; query: "h_1ac/string()" }
        XmlRole { name: "h_1eny"; query: "h_1eny/string()" }
        XmlRole { name: "h_1end"; query: "h_1end/string()" }
        XmlRole { name: "h_1kap"; query: "h_1kap/string()" }
        XmlRole { name: "h_1ago"; query: "h_1ago/string()" }
        XmlRole { name: "h_1ism"; query: "h_1ism/string()" }
        XmlRole { name: "h_1ish"; query: "h_1ish/string()" }
        XmlRole { name: "h_2ac"; query: "h_2ac/string()" }
        XmlRole { name: "h_2eny"; query: "h_2eny/string()" }
        XmlRole { name: "h_2end"; query: "h_2end/string()" }
        XmlRole { name: "h_2kap"; query: "h_2kap/string()" }
        XmlRole { name: "h_2ago"; query: "h_2ago/string()" }
        XmlRole { name: "h_2ism"; query: "h_2ism/string()" }
        XmlRole { name: "h_2ish"; query: "h_2ish/string()" }
        XmlRole { name: "h_bey"; query: "h_bey/string()" }
        XmlRole { name: "h_ben"; query: "h_ben/string()" }
        XmlRole { name: "h_ltav"; query: "h_ltav/string()" }
        XmlRole { name: "h_ltab"; query: "h_ltab/string()" }
        XmlRole { name: "h_52hafg"; query: "h_52hafg/string()" }
        XmlRole { name: "h_52hafy"; query: "h_52hafy/string()" }
        XmlRole { name: "h_52hafd"; query: "h_52hafd/string()" }
        XmlRole { name: "h_52hafyd"; query: "h_52hafyd/string()" }
        XmlRole { name: "h_52hafdd"; query: "h_52hafdd/string()" }
        XmlRole { name: "h_pdusd"; query: "h_pdusd/string()" }
        XmlRole { name: "h_ostl"; query: "h_ostl/string()" }
        XmlRole { name: "h_hao"; query: "h_hao/string()" }
        XmlRole { name: "h_fika"; query: "h_fika/string()" }
        XmlRole { name: "h_durum"; query: "h_durum/string()" }

        onStatusChanged: {
            if (status == XmlListModel.Ready) {
                indicator.visible = false
                indicator.running = false
                listDetay.visible = true
            } else if (status == XmlListModel.Loading) {
                indicator.running = true
                indicator.visible = true
                listDetay.visible = false
            }
        }
    }

    ListView {
        id: listDetay
        x: 0
        y: 0
        anchors.fill: parent

        Component {
            id: hvdelegates
            Item {
                id: hvdel
                width: listDetay.width
                height: (txt1.height + txt3.height +img1.height + gunluk.height) + 120
                Label {
                    id: header
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 30
                    color: "#0489B1"
                    font.pixelSize: 36
                    font.bold: true
                    text: h_adi
                }
                Image {id: hstate; source: "img/" + h_durum  + ".png"; x: (header.x - 70); y: header.y}
                Text {
                    id: txt1
                    width: (listDetay.width / 2) - 10
                    font.pixelSize: 22
                    color: "#FFFFFF"

                    x: 10
                    y: 100
                    text: "Alış: " + h_alis + "<br>" +
                          "İş. Mik.: " + h_imiktar + "<br>" +
                          "Net Değişim: " + h_ndeg + "<br><br>" +
                          "<font color='#0489B1'><center><b>1. Seans</b></center></font>" +
                          "Açılış: " + h_1ac + "<br>" +
                          "En Yüksek: " + h_1eny + "<br>" +
                          "En Düşük: " + h_1end + "<br>" +
                          "Kapanış: " + h_1kap + "<br>" +
                          "Ağ. Ort.: " + h_1ago + "<br>" +
                          "İş Mik.: " + h_1ism + "<br>" +
                          "İş Hacmi: " + h_1ac + "<br><br>" +
                          "<font color='#0489B1'><center><b>Bugün</b></center></font>" +
                          "En Yüksek: " + h_bey + "<br>" +
                          "En Düşük: " + h_ben
                }
                Text {
                    id: txt2
                    width: (listDetay.width / 2)
                    font.pixelSize: 22
                    color: "#FFFFFF"

                    x: (listDetay.width / 2)
                    y: 100
                    text: "Satış: " + h_satis + "<br>" +
                          "İş. Hac.: " + h_ihacim + "<br>" +
                          "Değişim (%): " + h_deg + "<br><br>" +
                          "<font color='#0489B1'><center><b>2. Seans</b></center></font>" +
                          "Açılış: " + h_2ac + "<br>" +
                          "En Yüksek: " + h_2eny + "<br>" +
                          "En Düşük: " + h_2end + "<br>" +
                          "Kapanış: " + h_2kap + "<br>" +
                          "Ağ. Ort.: " + h_2ago + "<br>" +
                          "İş Mik.: " + h_2ism + "<br>" +
                          "İş Hacmi: " + h_2ac + "<br><br>" +
                          "<font color='#0489B1'><center><b>Limitler (Seanslık)</b></center></font>" +
                          "Tavan: " + h_ltav + "<br>" +
                          "Taban: " + h_ltab
                }
                Text {
                    id: txt3
                    width: listDetay.width
                    font.pixelSize: 22
                    color: "#FFFFFF"

                    x: 10
                    y: (100 + txt1.height)
                    text: "<br><br>52 Haftalık Getiri: " + h_52hafg + "<br>" +
                          "52 Haftalık Yüksek: " + h_52hafy + "<br>" +
                          "52 Haftalık Düşük: " + h_52hafd + "<br>" +
                          "52 Haftalık Yüksek ($): " + h_52hafyd + "<br>" +
                          "52 Haftalık Düşük ($): " + h_52hafdd + "<br><br>" +
                          "Piyasa Değeri (USD): " + h_pdusd + "<br>" +
                          "Ödenmiş Sermaye (TL): " + h_ostl + "<br>" +
                          "Halka Açıklık Oranı: " + h_hao + "<br>" +
                          "Fiyat/Kazanç: " + h_fika
                }
                Image {
                    id: img1
                    y: (txt1.height + txt3.height) + 100
                    height: 234
                    width: 400
                    source: "http://app2.denizyatirim.com/gifs/deniznew/hissetic/" + h_adi + "E.gif"
                }
                Button {
                    id: gunluk
                    x: 10
                    y: (txt1.height + txt3.height + img1.height) + 110
                    width: ((parent.width / 3) - 10)
                    text: "Günlük"
                    onClicked: img1.source = "http://app2.denizyatirim.com/gifs/deniznew/hissetic/" + h_adi + "E.gif"
                }
                Button {
                    id: aylik
                    x: (gunluk.width + 15)
                    y: (txt1.height + txt3.height + img1.height) + 110
                    width: ((parent.width / 3) - 10)
                    text: "3 Aylık"
                    onClicked: img1.source = "http://app2.denizyatirim.com/gifs/deniznew/hisseucay/" + h_adi + ".gif"
                }
                Button {
                    x: (gunluk.width + aylik.width + 20)
                    y: (txt1.height + txt3.height + img1.height) + 110
                    width: ((parent.width / 3) - 10)
                    text: "Yıllık"
                    onClicked: img1.source = "http://app2.denizyatirim.com/gifs/deniznew/hisseyil/" + h_adi + ".gif"
                }

                Component.onCompleted: {indicator.visible = false}
            }
        }

        model: xmlModel
        delegate: hvdelegates
    }

    ScrollDecorator {
        flickableItem: listDetay
    }

    ToolBarLayout {
        id: commonTools
        visible: true
        ToolIcon {
            platformIconId: "toolbar-back"
            anchors.left: (parent === undefined) ? undefined : parent.left
            onClicked: {pageStack.pop()}
        }
        ToolIcon {
            platformIconId: "toolbar-refresh"
            onClicked: {xmlModel.reload()}
        }
        ToolIcon {
            platformIconId: "toolbar-view-menu"
            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: (myMenu.status == DialogStatus.Closed) ? myMenu.open() : myMenu.close()
        }
    }
}
