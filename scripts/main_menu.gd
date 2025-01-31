extends Node2D

@onready var name_input: LineEdit = $Background/MenuContainer/Menu/NameContainer/NameInput
@onready var assign_name_button: Button = $Background/MenuContainer/Menu/NameContainer/AssignName
@onready var photo_frame: TextureRect = $Background/MenuContainer/Menu/PhotoContainer/PhotoFrame
@onready var assign_photo_button: Button = $Background/MenuContainer/Menu/PhotoContainer/AssignPhoto
@onready var host_button: Button = $Background/MenuContainer/Menu/net/Host
@onready var connect_button: Button = $Background/MenuContainer/Menu/net/Connect
@onready var name_label: Label = $Background/player_name  # Aquí está el Label

const PLAYER_INFO_PATH = "res://data/player_info.json"
const SERVER_PORT = 26656
const IMAGE_SIZE = Vector2i(128, 128)  # Tamaño fijo de la imagen
var player_info = { "player_name": "", "photo_path": "" }

func _ready() -> void:
	if FileAccess.file_exists(PLAYER_INFO_PATH):
		var file = FileAccess.open(PLAYER_INFO_PATH, FileAccess.ModeFlags.READ)
		if file:
			var content = file.get_as_text()
			file.close()
			
			var json = JSON.new()
			if json.parse(content) == OK:
				var parsed_data = json.get_data()
				if parsed_data is Dictionary and parsed_data.has("player_name") and parsed_data.has("photo_path"):
					# Cargar el nombre
					player_info["player_name"] = parsed_data["player_name"]
					name_input.text = player_info["player_name"]
					name_input.placeholder_text = player_info["player_name"] if player_info["player_name"] != "" else "Introducir nombre"
					name_label.text = "Nombre: " + (player_info["player_name"] if player_info["player_name"] != "" else "Jugador")

					# Cargar la foto si existe
					player_info["photo_path"] = parsed_data["photo_path"]
					if player_info["photo_path"] != "":
						_set_photo_to_frame(player_info["photo_path"])
				else:
					print("Advertencia: El JSON no contiene las claves necesarias.")
			else:
				print("Error al analizar el JSON.")
		else:
			print("Error al abrir el archivo JSON.")
	else:
		print("No se encontró el archivo JSON en la ruta: %s" % PLAYER_INFO_PATH)

# Función para asignar el nombre
func _on_assign_name_pressed() -> void:
	var player_name = name_input.text.strip_edges()
	if player_name != "":
		player_info["player_name"] = player_name
		_save_player_info()

# Función para seleccionar la foto
func _on_assign_photo_pressed() -> void:
	var dialog = FileDialog.new()
	add_child(dialog)
	dialog.mode = FileDialog.FILE_MODE_OPEN_FILE
	dialog.filters = ["*.png ; PNG files", "*.jpg ; JPG files", "*.gif ; GIF files"]
	dialog.file_selected.connect(_on_photo_selected)
	dialog.popup()

# Función para procesar la imagen seleccionada
func _on_photo_selected(path: String) -> void:
	var img = Image.new()
	if img.load(path) == OK:
		img.resize(IMAGE_SIZE.x, IMAGE_SIZE.y)  # Redimensionar siempre a 128x128
		var texture = ImageTexture.create_from_image(img)
		photo_frame.texture = texture
		player_info["photo_path"] = path
		_save_player_info()
	else:
		print("Error al cargar la imagen desde la ruta:", path)

# Función para guardar la información del jugador
func _save_player_info() -> void:
	var file = FileAccess.open(PLAYER_INFO_PATH, FileAccess.ModeFlags.WRITE)
	if file:
		var json_data = JSON.stringify(player_info)
		file.store_string(json_data)
		file.close()
		print("Información del jugador guardada exitosamente.")
	else:
		print("Error al abrir el archivo para guardar la información.")

# Función para cargar la imagen desde JSON y redimensionarla si es necesario
func _set_photo_to_frame(path: String) -> void:
	var img = Image.new()
	if img.load(path) == OK:
		img.resize(IMAGE_SIZE.x, IMAGE_SIZE.y)  # Redimensionar a 128x128
		var texture = ImageTexture.create_from_image(img)
		photo_frame.texture = texture
	else:
		print("Error al cargar la imagen desde el JSON:", path)

# Función para iniciar el servidor
func _on_host_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(SERVER_PORT, 6)
	multiplayer.multiplayer_peer = peer
	get_tree().change_scene_to_file("res://scenes/waiting_room.tscn")

# Función para conectarse al servidor
func _on_connect_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/connect_menu.tscn")
