
# 🚀 Space War QML

Welcome to **Space War QML**, a fast-paced 2D space shooter built with **Qt/QML** and **C++**!  
Take control of your spaceship, dodge enemy attacks, and blast your way through endless waves of enemies.

![Space War Banner](https://github.com/javahedi/spaceWarQML/assets/figures/screenShot.png) <!-- Optional banner if you upload an image -->

---

## 🕹️ Gameplay Features

- 🎯 Smooth player controls with keyboard input
- 🛸 Different enemy types, including **zigzagging enemies**
- 🔊 Integrated sound effects via a custom **Audio Manager**
- 🧠 Simple enemy AI and bullet collision system
- ✨ Lightweight and fast — perfect for learning Qt Quick games!

---

## 📂 Project Structure

```plaintext
├── assets/               # Images, sounds, and other resources
├── AudioManager.qml       # Handles game audio
├── Bullet.qml             # Bullet logic
├── Enemy.qml              # Enemy behavior
├── EnemyZigzag.qml        # Special zigzagging enemy
├── Player.qml             # Player spaceship behavior
├── Main.qml               # Main game scene
├── CMakeLists.txt         # Project build configuration
├── main.cpp               # Entry point (C++)
├── README.md              # You're reading it!
└── .gitignore             # Files/folders ignored by Git
```

---

## 🚀 How to Build and Run

### Requirements
- **Qt 6** (or Qt 5.15+)
- **CMake** (for building C++ code)
- A C++ compiler (GCC/Clang/MSVC)

### Build Steps

```bash
git clone https://github.com/javahedi/spaceWarQML.git
cd spaceWarQML
mkdir build
cd build
cmake ..
make
./spaceWarQML
```

Or simply open the project in **Qt Creator** and click ▶️ *Run*.

---

## 📸 Screenshots

*(Coming soon — you can add images later!)*

---

## 📜 License

This project is licensed under the [MIT License](LICENSE).  
Feel free to use, modify, and distribute it!

---

## ✨ Author

Developed with ❤️ by [**Javad Vahedi**](https://github.com/javahedi)

> "Keep shooting for the stars — one line of code at a time."

---
