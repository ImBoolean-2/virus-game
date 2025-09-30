package virusgame

// Represents an organ on the table, including any applied viruses or medicines.
class OrganPile(val organCard: Card) {
    val appliedCards: MutableList<Card> = mutableListOf()

    // An organ is healthy if it's not infected or if it has been cured.
    // This logic will be expanded to handle vaccination and immunization.
    fun isHealthy(): Boolean {
        val virusCount = appliedCards.count { it.type == CardType.VIRUS }
        return virusCount == 0
    }

    fun addCard(card: Card) {
        appliedCards.add(card)
    }
}

class Player(val name: String, val photoPath: String) {
    val hand: MutableList<Card> = mutableListOf()
    // The body is a map of organ colors to their piles.
    val body: MutableMap<CardColor, OrganPile> = mutableMapOf()

    fun addCardToHand(card: Card) {
        if (hand.size < 3) {
            hand.add(card)
        }
    }

    // Checks if the player has won by collecting 4 different healthy organs.
    fun hasWon(): Boolean {
        val healthyOrganCount = body.values.count { it.isHealthy() }
        return healthyOrganCount >= 4
    }
}

class Deck {
    val cards: MutableList<Card> = mutableListOf()

    init {
        initializeDeck()
        shuffle()
    }

    private fun initializeDeck() {
        // For simplicity, we'll add a basic set of cards.
        // This can be expanded later to match the exact distribution of the real game.

        // Organs (5 of each main color, 1 multicolor)
        repeat(5) { cards.add(Card(CardType.ORGAN, CardColor.RED)) }
        repeat(5) { cards.add(Card(CardType.ORGAN, CardColor.GREEN)) }
        repeat(5) { cards.add(Card(CardType.ORGAN, CardColor.BLUE)) }
        repeat(5) { cards.add(Card(CardType.ORGAN, CardColor.YELLOW)) }
        cards.add(Card(CardType.ORGAN, CardColor.MULTICOLOR))

        // Viruses (4 of each main color, 1 multicolor)
        repeat(4) { cards.add(Card(CardType.VIRUS, CardColor.RED)) }
        repeat(4) { cards.add(Card(CardType.VIRUS, CardColor.GREEN)) }
        repeat(4) { cards.add(Card(CardType.VIRUS, CardColor.BLUE)) }
        repeat(4) { cards.add(Card(CardType.VIRUS, CardColor.YELLOW)) }
        cards.add(Card(CardType.VIRUS, CardColor.MULTICOLOR))

        // Medicines (4 of each main color, 4 multicolor)
        repeat(4) { cards.add(Card(CardType.MEDICINE, CardColor.RED)) }
        repeat(4) { cards.add(Card(CardType.MEDICINE, CardColor.GREEN)) }
        repeat(4) { cards.add(Card(CardType.MEDICINE, CardColor.BLUE)) }
        repeat(4) { cards.add(Card(CardType.MEDICINE, CardColor.YELLOW)) }
        repeat(4) { cards.add(Card(CardType.MEDICINE, CardColor.MULTICOLOR)) }
    }

    fun shuffle() {
        cards.shuffle()
    }

    fun deal(): Card? {
        return if (cards.isNotEmpty()) {
            cards.removeAt(0)
        } else {
            null
        }
    }
}

class GameManager(playerNames: List<String>) {
    val players: List<Player> = playerNames.map { Player(it, "") }
    val deck: Deck = Deck()
    var currentPlayerIndex: Int = 0

    fun startGame() {
        // Deal initial cards to each player
        for (player in players) {
            repeat(3) {
                deck.deal()?.let { card ->
                    player.addCardToHand(card)
                }
            }
        }
    }

    fun nextTurn() {
        currentPlayerIndex = (currentPlayerIndex + 1) % players.size
    }

    fun getCurrentPlayer(): Player {
        return players[currentPlayerIndex]
    }
}