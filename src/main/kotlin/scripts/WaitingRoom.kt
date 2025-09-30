package virusgame.scripts

import godot.Node2D
import godot.VBoxContainer
import godot.annotation.RegisterClass
import godot.annotation.RegisterFunction

@RegisterClass
class WaitingRoom : Node2D() {

    private lateinit var playerList: VBoxContainer

    @RegisterFunction
    override fun _ready() {
        playerList = getNodeAs("Background/PlayerList")

        multiplayer.peerConnected.connect(this, ::onPeerConnected)
        multiplayer.peerDisconnected.connect(this, ::onPeerDisconnected)

        updatePlayerList()
    }

    private fun updatePlayerList() {
        // Clear existing player entries
        for (child in playerList.getChildren()) {
            child.queueFree()
        }

        // Add the host (self) to the list
        // (Logic to add player display will be implemented later)

        // Add all connected peers
        for (peerId in multiplayer.getPeers()) {
            // (Logic to add player display will be implemented later)
        }
    }

    @RegisterFunction
    fun onPeerConnected(id: Long) {
        updatePlayerList()
    }

    @RegisterFunction
    fun onPeerDisconnected(id: Long) {
        updatePlayerList()
    }

    @RegisterFunction
    fun onBackButtonPressed() {
        getTree()?.changeSceneToFile("res://scenes/main_menu.tscn")
    }
}