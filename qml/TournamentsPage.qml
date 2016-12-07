import VPlayApps 1.0
import QtQuick 2.0

Page {
    id: tournamentsPage
    title: "Tournaments"

    // button to add a tournaments
    AppButton {
        id: addbutton
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Add Tournament"
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
        id: playersListView
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
                text: "Delete"
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
