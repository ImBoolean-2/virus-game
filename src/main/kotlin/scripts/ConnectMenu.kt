package virusgame.scripts

import godot.Button
import godot.Node2D
import godot.VBoxContainer
import godot.annotation.RegisterClass
import godot.annotation.RegisterFunction

@RegisterClass
class ConnectMenu : Node2D() {

    private lateinit var hostList: VBoxContainer
    private lateinit var backButton: Button
    private lateinit var connectButton: Button

    @RegisterFunction
    override fun _ready() {
        hostList = getNodeAs("Background/HostList")
        backButton = getNodeAs("Background/ButtonsContainer/Back")
        connectButton = getNodeAs("Background/ButtonsContainer/Connect")

        backButton.pressed.connect(this, ::onBackButtonPressed)
        connectButton.pressed.connect(this, ::onConnectButtonPressed)

        searchForServers()
    }

    private fun searchForServers() {
        // Placeholder for server discovery logic.
        // For now, it remains empty, similar to the original script.
    }

    @RegisterFunction
    fun onBackButtonPressed() {
        getTree()?.changeSceneToFile("res://scenes/main_menu.tscn")
    }

    @RegisterFunction
    fun onConnectButtonPressed() {
        // Logic to connect to a selected server will be implemented here.
    }
}