Virus-Game/
├── scenes/
│   ├── main.tscn  # Escena principal (menú, lobby)
│   ├── game.tscn  # Escena del tablero de juego
│   ├── connection.tscn  # Escena de conexión
│   └── ...         # Otras escenas (e.g., opciones, tutorial)
├── scripts/
│   ├── game.gd    # Lógica principal del juego
│   ├── player.gd  # Comportamiento del jugador
│   ├── virus.gd   # Comportamiento del virus
│   ├── cell.gd    # Comportamiento de la celda
│   ├── network.gd  # Manejo de la red
│   └── ...         # Otros scripts
├── assets/
│   ├── sprites/
│   │   ├── player.png
│   │   ├── virus.png
│   │   └── ...
│   ├── sounds/
│   │   ├── infect.wav
│   │   └── ...
│   ├── fonts/
│   └── ...
├── config/
│   ├── game.cfg  # Configuración del juego
│   └── ...
└── .gitignore
```

**Explicación de la estructura:**

* **scenes:** Contiene todas las escenas del juego. Cada escena es un archivo .tscn que define la jerarquía de nodos y sus propiedades.
* **scripts:** Aquí se almacenan todos los scripts de Godot, escritos en GDScript. Cada script se asocia a un nodo y define su comportamiento.
* **assets:** Contiene todos los recursos del juego, como imágenes, sonidos, fuentes, etc. Organízalos en subcarpetas para mantener una mejor estructura.
* **config:** Almacena archivos de configuración del juego, como el tamaño del tablero, las opciones de juego, etc.
* **.gitignore:** Este archivo ignora los archivos que no deseas incluir en tu control de versiones (e.g., archivos temporales, caché).
