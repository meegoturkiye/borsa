import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: appWindow

    initialPage: mainPage

    MainPage {
        id: mainPage
        orientationLock: PageOrientation.LockPortrait
    }

    QueryDialog {
        id: myDialog
        icon: "img/logo.png"
        titleText: "BorsaGo"
        message: "Bu uygulama apps-dev tarafından geliştirilmiştir.<br>Tüm hakları saklıdır.<br>Copyright © 2012 apps-dev."
    }

    Menu {
        id: myMenu
        visualParent: pageStack
        MenuLayout {
            MenuItem {
                id: about
                text: ("Hakkında")
                onClicked: myDialog.open()
            }

            MenuItem {
                id: exit
                text: ("Çıkış")
                onClicked: Qt.quit()
            }
        }
    }
}
