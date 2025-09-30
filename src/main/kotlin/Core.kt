package virusgame

enum class CardColor {
    RED,
    GREEN,
    BLUE,
    YELLOW,
    MULTICOLOR
}

enum class CardType {
    ORGAN,
    VIRUS,
    MEDICINE,
    TREATMENT
}

data class Card(val type: CardType, val color: CardColor)