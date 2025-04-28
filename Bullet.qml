// Bullet.qml

import QtQuick



Rectangle {
    id: bullet
    objectName: "bullet"  // 👈 each bullet has unique
    width: 10
    height: 20
    color: "yellow"

    property int speed: 10
    property Item player // refrence to player ( for score)


    function intersects(a, b) {
        return !(
            a.x + a.width < b.x ||
            a.x > b.x + b.width ||
            a.y + a.height < b.y ||
            a.y > b.y + b.height
        )
    }

    /*
    // Bullet movement
    Timer {
        interval: 16 //~60 fps
        running: true
        repeat: true
        onTriggered: {
            y -=speed
            // Destroy bullet if it goes off-screen
            if (bullet.y + bullet.height < 0) {
                bullet.destroy()
            }

            // Check collision with all enemies
            for (let i = 0; i < gameArea.children.length; i++) {
                let item = gameArea.children[i]
                if ((item.objectName === "enemy" || item.objectName === "enemyZigzag") && intersects(bullet, item))
                {
                    //console.log("💥 Hit!")
                    audioManager.playCollisionSound()
                    item.destroy()
                    bullet.destroy()
                    if (player) player.score += 1
                    break
                }
            }
        }
    }
    */
    function update() {
        y -= speed
        if ( y + height < 0) {
            destroy()
        }

        for (let i = 0; i < gameArea.children.length; i++) {
            let item = gameArea.children[i]
            if ((item.objectName === "enemy" || item.objectName === "enemyZigzag") && intersects(bullet, item)) {
                audioManager.playCollisionSound()
                item.destroy()
                destroy()
                if (player) player.score += 1
                break
            }
        }
    }
}
