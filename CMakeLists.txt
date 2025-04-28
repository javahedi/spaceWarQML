cmake_minimum_required(VERSION 3.16)

project(spaceWarQML VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appspaceWarQML
    main.cpp
)

qt_add_qml_module(appspaceWarQML
    URI spaceWarQML
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES Player.qml
        QML_FILES Enemy.qml
        QML_FILES Bullet.qml
        RESOURCES assets/figures/background1.png  assets/figures/background2.png assets/figures/bullet2.png assets/figures/enemy1.png assets/figures/enemy2.png assets/figures/enemy3.png assets/figures/ffff.png assets/figures/player1.png assets/figures/player2.png assets/sounds/backgroundMusic.mp3 assets/sounds/backgroundMusic2.mp3 assets/sounds/collision.mp3 assets/sounds/collision.wav assets/sounds/gameOver.mp3 assets/sounds/gameOver.wav assets/sounds/laser.mp3 assets/sounds/laser.wav
        QML_FILES AudioManager.qml
        QML_FILES EnemyZigzag.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appspaceWarQML PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appspaceWarQML
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appspaceWarQML
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appspaceWarQML
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
