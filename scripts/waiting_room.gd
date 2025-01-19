extends Node2D

@onready var player_list: VBoxContainer = $Background/PlayerList

const PLAYER_INFO_PATH = "res://data/player_info.json"
var player_info = {"player_name": "default", "photo_path": "res://assets/file.jpg"}

func _ready() -> void:
	_load_player_info()
	_actualizar_lista_jugadores()
	# Asegúrate de conectar correctamente las señales del multiplayer
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)

func _load_player_info() -> void:
	if FileAccess.file_exists(PLAYER_INFO_PATH):
		var file = FileAccess.open(PLAYER_INFO_PATH, FileAccess.ModeFlags.READ)
		var content = file.get_as_text()
		file.close()
		
		# Crear una instancia de JSON y analizar el contenido
		var json = JSON.new()
		var parse_result = json.parse(content)
		
		# Verificar si el análisis fue exitoso
		if parse_result == OK:
			var parsed_data = json.get_data()
			if parsed_data.has("player_name") and parsed_data.has("photo_path"):
				player_info["player_name"] = parsed_data["player_name"]
				player_info["photo_path"] = parsed_data["photo_path"]
			else:
				print("Advertencia: El archivo JSON no contiene las claves necesarias 'player_name' o 'photo_path'.")
		else:
			print("Error al analizar el archivo JSON.")
	else:
		print("No se encontró el archivo JSON en la ruta: %s" % PLAYER_INFO_PATH)

func _actualizar_lista_jugadores() -> void:
	player_list.get_children().clear()
	
	# Obtener la lista de peers conectados desde `multiplayer.get_peers()`
	var peers = multiplayer.get_peers()
	
	var container = HBoxContainer.new()
	var photo = TextureRect.new()
	var player_name = Label.new()

	if player_info["photo_path"] != "" and player_info["player_name"] != "":
		photo.texture = load(player_info["photo_path"])
		player_name.text = player_info["player_name"]
	else:
		photo.texture = load("res://data/default_photo.jpg")  # Imagen predeterminada
		player_name.text = "Host"
	
	container.add_child(photo)
	container.add_child(player_name)
	player_list.add_child(container)

	for peer_id in peers:
		var peer_container = HBoxContainer.new()
		var peer_photo = TextureRect.new()
		var peer_name = Label.new()

		peer_photo.texture = load("res://data/default_photo.jpg")  # Imagen de jugador por defecto
		peer_name.text = "Jugador %d" % peer_id

		peer_container.add_child(peer_photo)
		peer_container.add_child(peer_name)
		player_list.add_child(peer_container)

func _on_peer_connected(peer_id: int) -> void:
	print("Jugador conectado: %d" % peer_id)
	_actualizar_lista_jugadores()

func _on_peer_disconnected(peer_id: int) -> void:
	print("Jugador desconectado: %d" % peer_id)
	_actualizar_lista_jugadores()
