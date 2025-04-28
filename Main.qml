// Main.qml

import QtQuick
import QtQuick.Controls
import QtMultimedia


ApplicationWindow {
    id: win
    visible: true
    width: 480
    height: 640

    title: qsTr("Space War")


    function restartGame() {
        // Reset player
        player.reset()

        // Remove all enemies and bullets
        for (let i = gameArea.children.length - 1; i >= 0; i--) {
            let item = gameArea.children[i];
            if (item.objectName === "enemy" ||
                item.objectName === "enemyZigzag" ||
                item.objectName === "bullet") {
                item.destroy();
            }
        }

        // Hide Game Over menu
        gameOverMenu.visible = false;
    }




    // Audio manager instance
    AudioManager {
        id: audioManager
    }


    //Rectangle {
    //    id: gameArea
    //    anchors.fill: parent
    //    color: "Black"
    Image {
        id: gameArea
        anchors.fill: parent
        source: "assets/figures/background2.png"
        fillMode: Image.PreserveAspectCrop


        Player {
            id : player
            y: parent.height - height
            x: parent.width / 2 - width
            onGameOverTriggered:
                console.log("Game Over!")
        }




        // Central game loop — goes inside gameArea
        Timer {
            id: gameLoop
            interval: 16 // ~60 FPS
            running: true
            repeat: true
            onTriggered: {

                player.update()

                for (let i = 0; i < gameArea.children.length; i++) {
                    let item = gameArea.children[i]
                    if (item && typeof item.update === "function") {
                        item.update()
                    }
                }
            }
        }


        // Enemy template
        Component {
            id: enemyComponent
            Enemy {}
        }


        // Spawns enemies
        Timer {
            interval: 1000 // every 1 second
            repeat: true
            running: true
            onTriggered: {
                if (!player.gameOver) {  // Don't spawn enemies if game over
                    let enemy = enemyComponent.createObject(gameArea, {
                        "x": Math.random() * (gameArea.width - 40),
                        "y": -40, // start just off-screen
                        //"z": -1,
                        "player": player // Accessible player to enemy
                    })
                }
            }
        }


        // EnemyZigzag template
        Component {
            id: enemyZigzagComponent
            EnemyZigzag {}
        }

        // Spawns enemyZigzag
        Timer {
            interval: 5000 // every 10 second
            repeat: true
            running: true
            onTriggered: {
                if (!player.gameOver) {  // Don't spawn enemies if game over
                    let enemyZigzag = enemyZigzagComponent.createObject(gameArea, {
                        "player": player // Accessible player to enemy
                    })
                }
            }
        }


        // Bullet template
        Component {
            id: bulletComponent
            Bullet {}
        }

        /*
        Keys.onSpacePressed: {
            if (!player.gameOver) {
                let bullet = bulletComponent.createObject(gameArea, {
                    "x": player.x + player.width / 2 - 5,
                    "y": player.y - 20,
                    "player": player
                });
                audioManager.playShootSound()
            }
        }
        */
        Keys.onPressed: (event) => {
            player.keysPressed.add(event.key)

            if (event.key === Qt.Key_Space && !player.gameOver) {
                let bullet = bulletComponent.createObject(gameArea, {
                    "x": player.x + player.width / 2 - 5,
                    "y": player.y - 20,
                    "player": player
                });
                audioManager.playShootSound()
            }

            // get info about current number of enemy and bullet
            if (event.key === Qt.Key_I) {
                let enemies = gameArea.children.filter(item => item.objectName === "enemy").length
                let enemiesZigzag = gameArea.children.filter(item => item.objectName === "enemyZigzag").length
                let bullets = gameArea.children.filter(item => item.objectName === "bullet").length
                console.log("Enemies:", enemies, " Enemies Zigzag", enemiesZigzag," Bullets:", bullets)
            }

        }

        Keys.onReleased: (event) => {
            player.keysPressed.delete(event.key)
        }



        // Power display
        Text {
            id: powerText
            text: qsTr("Power:" + player.power)
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: 10
            font.pixelSize: 24
            color: "red"

        }

        // Power text update
        Connections {
            target: player
            function onPowerChanged() {
                powerText.text = "Power: " + player.power
            }
        }

        // Score display
        Text {
            id: scoreText
            text: qsTr("Score:" + player.score)
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 10
            font.pixelSize: 24
            color: "green"
        }

        // Score text update
        Connections {
            target: player
            function onScoreChanged() {
                scoreText.text = "Score: " + player.score
            }
        }


        // Game Over display
        //Text {
        //    id: gameOverText
        //    text: "Game Over!"
        //    anchors.centerIn: parent
        //    font.pixelSize: 40
        //    color: "white"
        //    visible: player.gameOver  // Only visible if gameOver is true
        //}

        Rectangle {
            id: gameOverMenu
            width: parent.width
            height: parent.height
            color: "#000000AA" // semi-transparent black
            visible: player.gameOver
            z: 10

            Column {
                anchors.centerIn: parent
                spacing: 20

                Text {
                    text: "Game Over"
                    font.pixelSize: 36
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                }

                Button {
                    text: "Play Again"
                    onClicked: restartGame()
                    width: 150
                    height: 40
                }
            }
        }

        // Connections to handle game over state
        Connections {
            target: player
            onGameOverChanged: {  // Triggered when the gameOver property changes
                if (player.gameOver) {
                    audioManager.onGameOver()
                } else {
                    audioManager.offGameOver()
                }


            }
        }


        // get info about current number of enemy and bullet
        //Timer {
        //    interval: 2000
        //    repeat: true
        //    running: true
        //    onTriggered: {
        //        let enemies = gameArea.children.filter(item => item.objectName === "enemy").length
        //        let bullets = gameArea.children.filter(item => item.objectName === "bullet").length
        //        console.log("Enemies:", enemies, "Bullets:", bullets)
        //    }
        //}



    }
}

