# Virus-Game

Este proyecto es un juego peer-to-peer desarrollado con Godot Engine. A continuación, se detalla la estructura del proyecto y la función de cada sección y archivo.

## Estructura del Proyecto

```mermaid
graph TD
	A[Root] --> B[scenes]
	A --> C[scripts]
	A --> D[assets]
	A --> E[config]
	A --> F[.gitignore]
	A --> G[README.md]
	A --> H[LICENSE]
	A --> I[project.godot]
	B --> B1[main.tscn]
	B --> B2[game.tscn]
	B --> B3[connection.tscn]
	B --> B4[card_deck.tscn]
	B --> B5[game_board.tscn]
	B --> B6[player_hand.tscn]
	C --> C1[game.gd]
	C --> C2[player.gd]
	C --> C3[virus.gd]
	C --> C4[card.gd]
	C --> C5[medicine.gd]
	C --> C6[organ.gd]
	C --> C7[treatment.gd]
	D --> D1[sprites]
	D --> D2[sounds]
	D --> D3[fonts]
	D1 --> D1a[player.png]
	D1 --> D1b[virus.png]
	D2 --> D2a[infect.wav]
	E --> E1[game_config.json]
	E --> E2[card_data.json]
	E --> E3[player_info.json]
```

## Explicación de la Estructura

### scenes
Contiene todas las escenas del juego. Cada escena es un archivo `.tscn` que define la jerarquía de nodos y sus propiedades.
- **main.tscn:** Escena principal del juego, que incluye el menú y el lobby.
- **game.tscn:** Escena del tablero de juego.
- **connection.tscn:** Escena de conexión para el modo peer-to-peer.
- **card_deck.tscn:** Escena que representa el mazo de cartas.
- **game_board.tscn:** Escena que representa el tablero de juego.
- **player_hand.tscn:** Escena que representa la mano del jugador.

### scripts
Aquí se almacenan todos los scripts de Godot, escritos en GDScript. Cada script se asocia a un nodo y define su comportamiento.
- **gameboard.gd:** Lógica principal del juego.
- **player.gd:** Comportamiento del jugador.
- **virus.gd:** Comportamiento del virus.
- **card.gd:** Lógica de las cartas.
- **medicine.gd:** Lógica de las medicinas.
- **organ.gd:** Lógica de los órganos.
- **treatment.gd:** Lógica de los tratamientos.

### assets
Contiene todos los recursos del juego, como imágenes, sonidos, fuentes, etc. Organízalos en subcarpetas para mantener una mejor estructura.
- **sprites:** Imágenes utilizadas en el juego.
  - **player.png:** Imagen del jugador.
  - **virus.png:** Imagen del virus.
- **sounds:** Archivos de sonido utilizados en el juego.
  - **infect.wav:** Sonido de infección.
- **fonts:** Fuentes utilizadas en el juego.

### config
Almacena archivos de configuración del juego, como el tamaño del tablero, las opciones de juego, etc.
- **game_config.json:** Configuración general del juego.
- **card_data.json:** Datos de las cartas.
- **player_info.json:** Información de los jugadores.

### .gitignore
Este archivo ignora los archivos que no deseas incluir en tu control de versiones (e.g., archivos temporales, caché).

### README.md
Este archivo proporciona información sobre el proyecto, su estructura y cómo configurarlo.

### LICENSE
Este archivo contiene la licencia del proyecto.

### project.godot
Archivo de configuración del proyecto de Godot.

## Flujo de Datos

```mermaid
sequenceDiagram
	participant Player1
	participant Player2
	participant Server

	Player1->>Server: Solicitud de conexión
	Server-->>Player1: Confirmación de conexión
	Player2->>Server: Solicitud de conexión
	Server-->>Player2: Confirmación de conexión
	Player1->>Player2: Sincronización de estado del juego
	Player2->>Player1: Confirmación de sincronización
	Player1->>Server: Enviar acción de juego
	Server-->>Player2: Actualizar estado del juego
	Player2->>Server: Enviar acción de juego
	Server-->>Player1: Actualizar estado del juego
```

Este flujo de datos muestra cómo los jugadores se conectan al servidor, sincronizan el estado del juego y envían acciones de juego entre sí a través del servidor.
