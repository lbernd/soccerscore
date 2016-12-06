import VPlayApps 1.0
import QtQuick 2.0


//import "./model"
/*

// EXAMPLE USAGE: import "PlayerModel" 1.0
// add the following piece of code inside your App { } to display the List Page

PlayersPage {

}

*/
ListView {
    id: playersPage
    anchors.fill: parent
    //    property var data: playerModel
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
    //    section.property: "name"
    delegate: SwipeOptionsContainer {
        id: container
        height: row.height

        enabled: !(isSnapped && isRight)

        //the actual list item
        SimpleRow {
            id: row
            Text {
                text: name
            }
            style.showDisclosure: false
        }

        //left swipe option (when swiping list item to right)
        leftOption: SwipeButton {
            text: "Delete"
            icon: IconType.trash
            backgroundColor: "red"
            height: row.height
            onClicked: {

                //TODO: currentIndex and Item does not update.
                playerModel.remove(playersPage.currentIndex)
                //playersPage.currentItem.deleteLater()
                //            playerModel.remove()
                //          row.item.name = "Option clicked"
                //          row.itemChanged()

                //hide left option when clicked
                container.hideOptions()
            }
        }

        //      //right swipe option (when swiping list item to left)
        //      rightOption: AppActivityIndicator {
        //        width: row.height
        //        anchors.centerIn: parent
        //      }

        //      //hide right option after timer finishes
        //      onRightOptionShown: hideTimer.start()

        //      property Timer hideTimer: Timer {
        //        running: false
        //        interval: 1000
        //        onTriggered: container.hideOptions()
        //      }
    }
}
