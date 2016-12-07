import VPlayApps 1.0
import QtQuick 2.0


//import "./model"
/*

// EXAMPLE USAGE: import "playerModel" 1.0
// add the following piece of code inside your App { } to display the List Page

PlayersPage {

}

*/
Page {

    // button to add a player
    AppButton {
        id: addbutton
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Add Player"
        onClicked: {
            playersModel.append({
                                    name: "Bernd",
                                    team: "1337"
                                })
        }
    }

    ListView {
        id: playersListView
        anchors.top: addbutton.bottom
        anchors.bottom: parent.bottom
        width: parent.width
        //    property var data: playersModel
        // TODO seperate model data.
        model: playersModel

        ListModel {
            id: playersModel
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
                    playersModel.remove(index)
                    //hide left option when clicked
                    //container.hideOptions()
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
}
