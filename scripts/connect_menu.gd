extends Node2D

@onready var host_list: HBoxContainer = $Background/HostList
@onready var back_button: Button = $Background/ButtonsContainer/Back
@onready var connect_button: Button = $Background/ButtonsContainer/Connect

func _ready() -> void:
	back_button.pressed.connect(_on_back_pressed)
	connect_button.pressed.connect(_on_connect_pressed)
	# Escanear redes locales
	_buscar_servidores()

func _buscar_servidores() -> void:
	# Limpiar todos los hijos actuales de host_list
	for child in host_list.get_children():
		host_list.remove_child(child)
		child.queue_free()

	# Simular la búsqueda de servidores locales
	for i in range(5):  # Crear 5 servidores de ejemplo
		var label = Label.new()
		label.text = "Servidor %d" % i
		host_list.add_child(label)

func _on_back_pressed() -> void:
	print("Cambiando a main_menu")
	get_tree().change_scene("res://scenes/main_menu.tscn")

func _on_connect_pressed() -> void:
	print("Conectando a un servidor...")
	# Implementar lógica para conectarse
