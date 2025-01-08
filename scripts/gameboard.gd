extends Node

const MAX_JUGADORES = 6
var jugadores_conectados = []
var servidor = null
var es_host = false

func _ready() -> void:
	iniciar_servidor()

func iniciar_servidor() -> void:
	servidor = NetworkedMultiplayerENet.new()
	var puerto = 26656
	var max_conexiones = MAX_JUGADORES - 1  # El host no cuenta como cliente
	if servidor.create_server(puerto, max_conexiones) == OK:
		get_tree().set_network_peer(servidor)
		es_host = true
		print("Servidor iniciado en el puerto %d. Esperando jugadores..." % puerto)
		jugadores_conectados.append("Host")  # El host es el primer jugador
		mostrar_jugadores()
	else:
		print("Error al iniciar el servidor.")

# Maneja conexiones de clientes
func _on_peer_connected(peer_id):
	jugadores_conectados.append("Jugador %d" % peer_id)
	print("Jugador %d se ha unido a la sala." % peer_id)
	mostrar_jugadores()

# Maneja desconexiones de clientes
func _on_peer_disconnected(peer_id):
	jugadores_conectados.erase("Jugador %d" % peer_id)
	print("Jugador %d se ha desconectado." % peer_id)
	mostrar_jugadores()

# Muestra los jugadores conectados en la consola
func mostrar_jugadores():
	print("Jugadores conectados:")
	for jugador in jugadores_conectados:
		print(" - %s" % jugador)

# Inicia la partida cuando el host escribe "Iniciar" en la consola
func _process(delta):
	if es_host:
		if Input.is_action_just_pressed("ui_accept"):  # "Enter" por defecto
			print("Escribe 'Iniciar' en la consola para comenzar la partida.")
		var entrada = OS.get_stdin_string().strip_edges()  # Leer entrada de consola
		if entrada == "Iniciar":
			iniciar_partida()

# Lógica para iniciar la partida
func iniciar_partida():
	print("Iniciando partida con %d jugadores." % jugadores_conectados.size())
	rpc("iniciar_juego_remoto", jugadores_conectados.size())  # Notificar a todos
	jugadores_conectados.clear()

# Inicia el juego en los clientes
remote func iniciar_juego_remoto(num_jugadores: int):
	print("Partida iniciada con %d jugadores conectados." % num_jugadores)
	iniciar_partida_local()

# Configura la partida local (host y clientes)
func iniciar_partida_local():
	# Aquí iría la lógica para comenzar la partida
	print("¡Comenzando la partida!")
