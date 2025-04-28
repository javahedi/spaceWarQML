// enemyZig.qml
import QtQuick


Image {
    id: enemyZigzag
    objectName: "enemyZigzag" // each enemy has unique
    width: 40
    height: 40
    source: "assets/figures/enemy2.png"
    fillMode: Image.PreserveAspectFit

    property real speed: 1.5
    property real zigzagAmplitude: 20
    property real zigzagFrequency: 0.02
    property Item player
    property int gameAreaHeight: 640 // default fallback

    y: -40 // Random starting position for horizontal movement
    x: Math.random() * (gameArea.width - 40)
    //z: -5



    function intersects(a, b) {
        return !(
            a.x + a.width < b.x ||
            a.x > b.x + b.width ||
            a.y + a.height < b.y ||
            a.y > b.y + b.height
        )
    }



    /*
    Timer {
        interval: 16 // ~60 FPS
        running: true
        repeat: true
        onTriggered: {

            enemyZigzag.y += speed
            // Move horizontally in a sinusoidal pattern (zigzag motion)
            let newX = enemyZigzag.x + zigzagAmplitude * Math.sin(zigzagFrequency * enemyZigzag.y)
            // Clamp x between 0 and (gameArea.width - enemy width)
            newX = Math.max(0, Math.min(newX, gameArea.width - enemyZigzag.width))
            enemyZigzag.x = newX


            // Destroy when off-screen
            if ( y > gameAreaHeight ) {
                enemyZigzag.destroy()
            }

            // Collision detection
            if (player && intersects(enemyZigzag, player)) {
                //console.log("💥 Collision detected!")
                player.reducePower()
                enemyZigzag.destroy()
            }

        }
    }
    */

    function update() {
        y += speed
        let newX = x + zigzagAmplitude * Math.sin(zigzagFrequency * y)
        x = Math.max(0, Math.min(newX, gameArea.width - width))

        if (y > gameAreaHeight) {
            destroy()
        }

        if (player && intersects(enemyZigzag, player)) {
            player.reducePower()
            destroy()
        }
    }


}
