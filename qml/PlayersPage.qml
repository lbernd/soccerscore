import VPlayApps 1.0
import QtQuick 2.0


//import "./model"
/*

// EXAMPLE USAGE: import "PlayerModel" 1.0
// add the following piece of code inside your App { } to display the List Page

PlayersPage {

}

*/
ListPage {
    id: playersPage

    // TODO seperate model data.
    model: playerModel

    ListModel {
        id: playerModel
        ListElement {
            name: "Bernd"
            team: "1337"
        }
        ListElement {
            name: "Chris"
            team: "1337"
        }
        ListElement {
            name: "Jane"
            team: "Rocket"
        }
        ListElement {
            name: "Victor"
            team: "Rocket"
        }
        ListElement {
            name: "Wane"
            team: "42"
        }
        ListElement {
            name: "Franz"
            team: "42"
        }
    }
    section.property: "name"
}
