import VPlayApps 1.0
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
    Navigation {
        id: navigation
        drawer.drawerPosition: drawer.drawerPositionLeft
        // headerView: NavHeader {} to add nice stuff or login information above and below the Navigation items.
        // footerView: NavFooter {}

        //this overrides the default mode of drawer on android and tabs elsewhere
        //navigationMode: navigationModeTabsAndDrawer
        NavigationItem {
            title: "Home"
            icon: IconType.home

            NavigationStack {
                WelcomePage {
                }
            }
        }
        NavigationItem {
            title: "Tournament"
            icon: IconType.soccerballo

            NavigationStack {
                TournamentsPage {
                }
            }
        }
        NavigationItem {
            title: "Players"
            icon: IconType.users

            NavigationStack {
                PlayersPage {
                }
            }
        }
    }
}
