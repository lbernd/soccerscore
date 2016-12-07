import VPlayApps 1.0
import QtQuick 2.0


//import "./model"
/*
Page to show and manage players. Delete and adding of users is possible.
*/
Page {
    id: page
    title: "Players"

    // button to add a player
    AppButton {
        id: addbutton
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Add Player"
        onClicked: {
            InputDialog.inputTextSingleLine(page, qsTr("Add Player"),
                                            qsTr("Enter name..."),
                                            function (ok, text) {
                                                if (ok)
                                                    playersModel.append({
                                                                            name: text,
                                                                            team: "none"
                                                                        })
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
        }
    }
}
