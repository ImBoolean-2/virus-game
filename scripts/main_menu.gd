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
var player_info = { "player_name": "", "photo_path": "" }

func _ready() -> void:
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
			
			# Verificar si el archivo JSON contiene las claves necesarias
			if parsed_data.has("player_name") and parsed_data.has("photo_path"):
				# Cargar el nombre
				var player_name = parsed_data["player_name"]
				player_info["player_name"] = player_name
				name_input.text = player_name
				# Establecer el placeholder text si no tiene un nombre
				name_input.placeholder_text = player_name if player_name != "" else "Introducir nombre"
				# Actualizar el label de nombre
				name_label.text = "Nombre: " + (player_name if player_name != "" else "Jugador")
				
				# Cargar la foto si existe
				var photo_path = parsed_data["photo_path"]
				player_info["photo_path"] = photo_path
				if photo_path != "":
					_set_photo_to_frame(photo_path)
			else:
				print("Advertencia: El archivo JSON no contiene las claves necesarias 'player_name' o 'photo_path'.")
		else:
			print("Error al analizar el archivo JSON.")
	else:
		print("No se encontró el archivo JSON en la ruta: %s" % PLAYER_INFO_PATH)

# Función para asignar el nombre
func _on_assign_name_pressed() -> void:
	var player_name = name_input.text.strip_edges()
	if player_name != "":
		player_info["player_name"] = player_name
		_save_player_info()

# Función para asignar la foto
func _on_assign_photo_pressed() -> void:
	var dialog = FileDialog.new()
	add_child(dialog)
	dialog.mode = FileDialog.FILE_MODE_OPEN_FILE
	dialog.filters = ["*.png ; PNG files", "*.jpg ; JPG files", "*.gif ; GIF files"]
	dialog.file_selected.connect(_on_photo_selected)
	dialog.popup()

# Función que se llama cuando se selecciona una foto
func _on_photo_selected(path: String) -> void:
	var img = Image.new()
	if img.load(path) == OK:
		img.resize(128, 128)
		var texture = ImageTexture.create_from_image(img)
		photo_frame.texture = texture
		player_info["photo_path"] = path
		_save_player_info()
		
func _save_player_info() -> void:
	var file = FileAccess.open(PLAYER_INFO_PATH, FileAccess.ModeFlags.WRITE)
	if file:
		var json_data = JSON.stringify(player_info)
		file.store_string(json_data)
		file.close()
		print("Información del jugador guardada exitosamente.")
	else:
		print("Error al abrir el archivo para guardar la información.")

func _set_photo_to_frame(path: String) -> void:
	# Cargar la imagen como un recurso Image
	var img = Image.new()
	if img.load(path) == OK:
		# Redimensionar la imagen a 128x128
		img.resize(128, 128)
		# Crear una textura a partir de la imagen redimensionada
		var texture = ImageTexture.create_from_image(img)
		photo_frame.texture = texture
	else:
		print("Error al cargar la imagen desde la ruta: ", path)

# Función para iniciar el servidor
func _on_host_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(SERVER_PORT, 6)
	multiplayer.multiplayer_peer = peer
	get_tree().change_scene("res://scenes/waiting_room.tscn")

# Función para conectarse al servidor
func _on_connect_pressed() -> void:
	get_tree().change_scene("res://scenes/connect_menu.tscn")
