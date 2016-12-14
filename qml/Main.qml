import VPlayApps 1.0
import VPlay 2.0
import QtQuick 2.0


/*
  App to manage players and tournaments for table football games.
    */
App {
    // You get free licenseKeys from http://v-play.net/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the V-Play Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from http://v-play.net/licenseKey>"
    id: theApp

    property bool applicationFirstRun: false

    Storage {
        id: appStorage

        Component.onCompleted: {
            //secondRun logic
            var secondRun = "wtkljaw34jtaw34zlkjw34el"
            var isSecondRun = appStorage.getValue(secondRun)
            if (isSecondRun === undefined) {
                // if undefined is returned, this means the app was not started before
                applicationFirstRun = true
                console.debug("First Run")
                // now the application was started at least once, so set the flag to true
                appStorage.setValue(secondRun, true)
            }
        }
    }

    Navigation {
        id: navigation
        drawer.drawerPosition: drawer.drawerPositionLeft
        // headerView: NavHeader {} to add nice stuff or login information above and below the Navigation items.
        // footerView: NavFooter {}

        //this overrides the default mode of drawer on android and tabs elsewhere
        //navigationMode: navigationModeTabsAndDrawer
        NavigationItem {
            title: qsTr("Home")
            icon: IconType.home

            NavigationStack {
                WelcomePage {
                }
            }
        }
        NavigationItem {
            title: qsTr("Tournament")
            icon: IconType.soccerballo

            NavigationStack {
                TournamentsPage {
                }
            }
        }
        NavigationItem {
            title: qsTr("Players")
            icon: IconType.users

            NavigationStack {
                PlayersPage {
                }
            }
        }
    }
}
