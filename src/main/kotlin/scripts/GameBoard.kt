package virusgame.scripts

import godot.Node2D
import godot.annotation.RegisterClass
import godot.annotation.RegisterFunction
import virusgame.GameManager

@RegisterClass
class GameBoard : Node2D() {

    private lateinit var gameManager: GameManager

    @RegisterFunction
    override fun _ready() {
        // Initialize the game with a list of players.
        // For now, we'll use placeholder names.
        val playerNames = listOf("Player 1", "IA_DIRECTOR")
        gameManager = GameManager(playerNames)
        gameManager.startGame()

        // Initial render of the game state.
        renderGameBoard()
    }

    private fun renderGameBoard() {
        // This function will be responsible for drawing the cards,
        // player names, and other UI elements.
        // The implementation will be added later.
    }

    private fun onCardPlayed() {
        // This function will handle the logic when a player plays a card.
        // It will update the game state and re-render the board.
        gameManager.nextTurn()
        renderGameBoard()
    }
}