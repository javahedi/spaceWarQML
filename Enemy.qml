// Enemy.qml
import QtQuick



Image {
    id: enemy
    objectName: "enemy" // 👈 each enemy has unique
    width: 40
    height: 40
    source: "assets/figures/enemy1.png"
    fillMode: Image.PreserveAspectFit

    property real speed: 1.5
    property Item player
    property int gameAreaHeight: 640 // default fallback



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

            enemy.y += speed

            // Destroy when off-screen
            if ( y > gameAreaHeight ) {
                enemy.destroy()
            }

            // Collision detection
            if (player && intersects(enemy, player)) {
                //console.log("💥 Collision detected!")
                player.reducePower()
                enemy.destroy()
            }


        }
    }
    */
    function update() {
        y += speed
        if (y > gameAreaHeight) {
            destroy()
        }

        if (player && intersects(enemy, player)) {
            player.reducePower()
            destroy()
        }
    }
}
