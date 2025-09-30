package virusgame.scripts

import godot.*
import godot.annotation.RegisterClass
import godot.annotation.RegisterFunction
import godot.core.Vector2i

@RegisterClass
class MainMenu : Node2D() {

    // UI Node properties will be added here later.
    // Example: lateinit var nameInput: LineEdit

    @RegisterFunction
    override fun _ready() {
        // Logic to load player data will be implemented here.
    }

    @RegisterFunction
    fun onHostButtonPressed() {
        getTree()?.changeSceneToFile("res://scenes/waiting_room.tscn")
    }

    @RegisterFunction
    fun onConnectButtonPressed() {
        getTree()?.changeSceneToFile("res://scenes/connect_menu.tscn")
    }

    @RegisterFunction
    fun onAssignNameButtonPressed() {
        // Logic to save the player's name will be implemented here.
    }

    @RegisterFunction
    fun onAssignPhotoButtonPressed() {
        // Logic to open a file dialog and select a photo will be implemented here.
    }
}