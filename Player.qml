// Player.qml

import QtQuick
import QtQuick.Controls



//Rectangle {
//    id: player
//    width: 50
//    height: 50
//    color: "cyan"
Image {
    id: player
    width: 70
    height: 70
    source: "assets/figures/player1.png"
    fillMode: Image.PreserveAspectFit
    focus: true  // this lets it receive key events

    property int speed: 20
    property int initialPower: 5
    property int power: initialPower
    property int score: 0
    property bool gameOver: false
    signal gameOverTriggered()

    property var keysPressed: new Set()

    function reducePower() {
        if (power > 0) {
            power--
        }
        if (power <= 0 && !gameOver) {
            gameOver = true
            //console.log("Game Over!")
            gameOverTriggered()  // 👈 Emit the signal
        }
    }


    function reset() {
        x = parent.width / 2 - width / 2
        y = parent.height - height
        power = initialPower
        score = 0
        gameOver = false
    }

    function move(dx, dy) {
        if (gameOver) return

        let newX = x + dx
        let newY = y + dy

        if (newX >=0 && newX + width <= parent.width)
            x = newX
        if (newY >= 0 && newY + height <= parent.height)
                y = newY
    }

    function update() {
        if (gameOver) return;

        let dx = 0
        let dy = 0

        const speed = 5

        if (keysPressed.has(Qt.Key_Left)) {
            dx -= speed
        }
        if (keysPressed.has(Qt.Key_Right)) {
            dx += speed
        }
        if (keysPressed.has(Qt.Key_Up)) {
            dy -= speed
        }
        if (keysPressed.has(Qt.Key_Down)) {
            dy += speed
        }

        move(dx, dy)
    }



    /*
    Keys.onLeftPressed: {
        if (!gameOver && x - speed >= 0)
            x -= speed
    }

    Keys.onRightPressed: {
        if (!gameOver && x + width + speed <= parent.width)
            x += speed
    }

    Keys.onUpPressed: {
        if (!gameOver && y - speed >= 0)
            y -= speed
    }

    Keys.onDownPressed: {
        if (!gameOver && y + height + speed <= parent.height)
            y += speed
    }
    */
    //Keys.onLeftPressed: move(-speed, 0)
    //Keys.onRightPressed: move(speed, 0)
    //Keys.onUpPressed: move(0, -speed)
    //Keys.onDownPressed: move(0, speed)


}
