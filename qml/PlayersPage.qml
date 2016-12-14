import VPlayApps 1.0
import VPlay 2.0
import QtQuick 2.0


//import "./model"
/*
Page to show and manage players. Delete and adding of users is possible user are stored persistently.
*/
Page {
    id: playersPage
    title: qsTr("Players")

    Component.onCompleted: myStorage.initPlayers()

    // button to add a player
    rightBarItem: NavigationBarRow {
        IconButtonBarItem {
            icon: IconType.plus
            //not used atm see https://v-play.net/doc/vplayapps-navigationbaritem/#title-prop
            title: qsTr("Add Player")
            onClicked: InputDialog.inputTextSingleLine(page,
                                                       qsTr("Add Player"),
                                                       qsTr("Enter name..."),
                                                       function (ok, text) {
                                                           if (ok)
                                                               addPlayer({
                                                                             name: text,
                                                                             team: "none"
                                                                         })
                                                       })
        }
    }
    /* Adds player to player list and updates Storage.*/
    function addPlayer(player) {
        //jsobject player
        playersModel.append(player)
        console.debug("AddedPlayer....")
        myStorage.updatePlayers()
    }
    Storage {
        id: myStorage
        property string playerStorageKey: "PlayerStorageV0.1"

        //this is JS probably data managent should be done somewhere else.
        /*Updates stored player information.*/
        function updatePlayers() {
            for (var i = 0; i < playersModel.count; i++) {
                //id probably not necessary because id Info is atm stored in storage key.
                myStorage.setValue(playerStorageKey + "P" + i, {
                                       id: i,
                                       name: playersModel.get(i).name,
                                       team: playersModel.get(i).team
                                   })
                console.debug(playerStorageKey + "P" + i)
            }
            //Set number of players. No idea if playersModel.count can change in the meantime.
            myStorage.setValue(playerStorageKey + "P", playersModel.count)
        }
        /*Reads players from localStorage and adds it to the model.*/
        function initPlayers() {
            //Read the number of players from Storage.
            var numberOfPlayers = myStorage.getValue(playerStorageKey + "P")
            if (numberOfPlayers) {
                //numberOfPlayers is not 0
                console.debug("Load players...")
                //callback usage possible for slow or online storage.
                for (var i = 0; i < numberOfPlayers; i++) {
                    var player = myStorage.getValue(playerStorageKey + "P" + i)
                    playersModel.append({
                                            name: player.name,
                                            team: player.team
                                        })
                }
            } else {
                //0 players or not defined(first run)
                if (theApp.applicationFirstRun) {
                    PlayersPage.addPlayer({
                                              name: "Bernd",
                                              team: "1337"
                                          })
                } else {
                    console.debug("No players stored")
                }
            }
        }
    }

    ListView {
        id: playersListView
        anchors.fill: parent
        //    property var data: playersModel
        // TODO seperate model data.
        model: playersModel

        ListModel {
            id: playersModel
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
                    playersModel.remove(index)
                    myStorage.updatePlayers()
                    //hide left option when clicked
                    //container.hideOptions()
                }
            }
        }
    }
}
