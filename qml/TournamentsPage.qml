import VPlayApps 1.0
import VPlay 2.0
import QtQuick 2.0


/*
  Page contains tournament information. Options to delete and add tournaments.
        */
Page {
    id: tournamentsPage
    title: qsTr("Tournaments")

    Component.onCompleted: myStorage.initTournaments()

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
    function addTournament(tournament) {
        //jsobject player
        tournamentsModel.append(tournament)
        console.debug("AddedTournament....")
        myStorage.updateTournaments()
    }
    Storage {
        id: myStorage
        property string tournamentsStorageKey: "TournamentStorageV0.1"

        /*Updates stored tournaments information.*/
        function updateTournaments() {
            for (var i = 0; i < tournamentsModel.count; i++) {
                //id probably not necessary because id Info is atm stored in storage key.
                myStorage.setValue(tournamentsStorageKey + "T" + i, {
                                       id: i,
                                       name: tournamentsModel.get(i).name,
                                       date: tournamentsModel.get(i).date
                                   })
                console.debug(tournamentsStorageKey + "T" + i)
            }
            //Set number of tournaments. No idea if tournamentsModel.count can change in the meantime.
            myStorage.setValue(tournamentsStorageKey + "T",
                               tournamentsModel.count)
        }
        /*Reads tournaments from localStorage and adds it to the model.*/
        function initTournaments() {
            //Read the number of tournaments from Storage.
            var numberOfTournaments = myStorage.getValue(
                        tournamentsStorageKey + "T")
            if (numberOfTournaments) {
                //numberOfTournaments is not 0
                console.debug("Load tournaments...")
                //callback usage possible for slow or online storage.
                for (var i = 0; i < numberOfTournaments; i++) {
                    var tournament = myStorage.getValue(
                                tournamentsStorageKey + "T" + i)
                    tournamentsModel.append({
                                                name: tournament.name,
                                                date: tournament.date
                                            })
                }
            } else {
                //0 tournaments or not defined(first run)
                if (theApp.applicationFirstRun) {
                    tournamentsPage.addTournament({
                                                      name: "Nikolotunier",
                                                      date: "6.12.2016"
                                                  })
                    tournamentsPage.addTournament({
                                                      name: "Christmas tournament",
                                                      date: "24.12.2016"
                                                  })
                } else {
                    console.debug("No tournaments stored")
                }
            }
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
