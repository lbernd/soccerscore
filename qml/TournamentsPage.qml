import VPlayApps 1.0
import QtQuick 2.0

/*
  Page contains tournament information. Options to delete and add tournaments.
*/
Page {
    id: tournamentsPage
    title: qsTr("Tournaments")

    // button to add a tournaments
    AppButton {
        id: addbutton
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("Add Tournament")
        onClicked: {
            InputDialog.inputTextSingleLine(tournamentsPage,
                                            qsTr("Add Tournament"),
                                            qsTr("Enter name..."),
                                            function (ok, text) {
                                                if (ok)
                                                    tournamentsModel.append({
                                                                                name: text,
                                                                                date: "none"
                                                                            })
                                            })
        }
    }

    ListView {
        id: tournamentsListView
        anchors.top: addbutton.bottom
        anchors.bottom: parent.bottom
        width: parent.width
        // TODO seperate model data.
        model: tournamentsModel

        ListModel {
            id: tournamentsModel
            ListElement {
                name: "Nikolotunier"
                date: "6.12.2016"
            }
            ListElement {
                name: "Christmas tournament"
                team: "24.12.2016"
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
                text: qsTr("Delete")
                icon: IconType.trash
                backgroundColor: "red"
                height: row.height
                onClicked: {
                    tournamentsModel.remove(index)
                }
            }
        }
    }
}
