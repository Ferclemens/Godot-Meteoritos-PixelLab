class_name Nivel
extends Node2D

#Atributos export
export var explosion:PackedScene = preload("res://Juego/Explosiones/Explosion.tscn")


# Atributos onready
onready var contenedor_proyectiles: Node
onready var sonido_explosion:AudioStreamPlayer2D = $explosionSFX
# Metodos
func _ready() -> void:
	conectar_seniales()
	crear_contenedores()
	
func conectar_seniales() -> void:
	Eventos.connect("disparo", self, "_on_disparo")
	Eventos.connect("nave_destruida",self,"_on_nave_destruida")

func crear_contenedores() -> void:
	contenedor_proyectiles = Node.new()
	contenedor_proyectiles.name = "ContenedorProyectiles"
	add_child(contenedor_proyectiles)

func _on_disparo(proyectil:Proyectil_principal) -> void:
	contenedor_proyectiles.add_child(proyectil)

func _on_nave_destruida(posicion: Vector2, num_explosiones: int) -> void:
	for i in range(num_explosiones):
		var new_explosion:Node2D = explosion.instance()
		new_explosion.global_position = posicion
		add_child(new_explosion)
		yield(get_tree().create_timer(0.6),"timeout")
