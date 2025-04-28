// AudioManager.qml

import QtQuick
import QtMultimedia

Item {

    // Background music
    MediaPlayer {
       id: backgroundMusic
       source: "assets/sounds/backgroundMusic2.mp3"
       audioOutput: AudioOutput {
           id: output
           volume: 0.1
       }
       autoPlay: true
       loops: MediaPlayer.Infinite
    }

    // Game Over music
    MediaPlayer {
        id: gameOverMusic
        audioOutput: AudioOutput {
            volume: 0.8
        }
        source: "assets/sounds/gameOver.mp3"

        loops: MediaPlayer.Infinite
        // Do not auto-play here.
    }


    // Shooting sound effect
    SoundEffect {
        id: shootSound
        source: "assets/sounds/laser.wav"
        volume: 0.05
    }

    // Collisoin sound effect
    SoundEffect {
        id: colliosionSound
        source: "assets/sounds/collision.wav"
        volume: 0.05
    }

    // Method to stop background music and play game over music
    function onGameOver() {
        backgroundMusic.stop()
        gameOverMusic.play()
    }

    function offGameOver() {
        backgroundMusic.play()
        gameOverMusic.stop()
    }


    // Method to play shoot sound
    function playShootSound() {
        shootSound.play();
    }

    // Method to play collision sound
    function playCollisionSound() {
        colliosionSound.play();
    }
}
