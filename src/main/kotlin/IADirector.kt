package virusgame

sealed class AIAction
data class PlayCard(val card: Card, val targetPlayer: Player? = null, val targetOrganColor: CardColor? = null) : AIAction()
data class DiscardCards(val cards: List<Card>) : AIAction()

class IADirector(private val gameManager: GameManager) {

    fun setupGame() {
        gameManager.deck.shuffle()
        for (player in gameManager.players) {
            repeat(3) {
                gameManager.deck.deal()?.let { card ->
                    player.addCardToHand(card)
                }
            }
        }
    }

    fun decideNextMove(aiPlayer: Player): AIAction {
        // Priority 1: Win the game
        for (card in aiPlayer.hand) {
            if (card.type == CardType.ORGAN && !aiPlayer.body.containsKey(card.color)) {
                if (aiPlayer.body.values.count { it.isHealthy() } == 3) {
                    return PlayCard(card, aiPlayer, card.color)
                }
            }
        }

        // Priority 2: Sabotage opponent closest to winning
        val opponent = gameManager.players
            .filter { it != aiPlayer }
            .maxByOrNull { it.body.values.count { it.isHealthy() } }

        if (opponent != null) {
            val virusCard = aiPlayer.hand.find { it.type == CardType.VIRUS }
            if (virusCard != null) {
                val targetOrgan = opponent.body.values.find { it.isHealthy() }
                if (targetOrgan != null && (virusCard.color == targetOrgan.organCard.color || virusCard.color == CardColor.MULTICOLOR)) {
                    return PlayCard(virusCard, opponent, targetOrgan.organCard.color)
                }
            }
        }

        // Priority 3: Improve own body (cure or play organ)
        val medicineCard = aiPlayer.hand.find { it.type == CardType.MEDICINE }
        if (medicineCard != null) {
            val infectedOrgan = aiPlayer.body.values.find { !it.isHealthy() }
            if (infectedOrgan != null && (medicineCard.color == infectedOrgan.organCard.color || medicineCard.color == CardColor.MULTICOLOR)) {
                return PlayCard(medicineCard, aiPlayer, infectedOrgan.organCard.color)
            }
        }

        val organCard = aiPlayer.hand.find { it.type == CardType.ORGAN && !aiPlayer.body.containsKey(it.color) }
        if (organCard != null) {
            return PlayCard(organCard, aiPlayer, organCard.color)
        }

        // Priority 4: Discard
        return DiscardCards(listOf(aiPlayer.hand.first()))
    }
}