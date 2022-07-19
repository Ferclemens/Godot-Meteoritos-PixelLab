class_name Player
extends RigidBody2D



# Atributos Export

export var potencia_motor:int = 20
export var potencia_rotacion:int = 150

#Atributos
var empuje:Vector2 = Vector2.ZERO
var dir_rotacion:int = 0

# Metodos
func _process(delta: float) -> void:
	player_input()
	
func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	apply_central_impulse(empuje.rotated(rotation))
	apply_torque_impulse(dir_rotacion * potencia_rotacion)
	#print(rad2deg(rotation))
	#print(empuje.rotated(rotation))

func player_input() -> void:
	# Empuje - movimiento de player 
	empuje = Vector2.ZERO
	if Input.is_action_pressed("mover_adelante"):
		empuje = Vector2(potencia_motor, 0)
	elif Input.is_action_pressed("mover_atras"):
		empuje = Vector2(-potencia_motor, 0)
	
	# Rotacion
	dir_rotacion = 0
	if Input.is_action_pressed("rotar_horario"):
		dir_rotacion +=1
	elif Input.is_action_pressed("rotar_antihorario"):
		dir_rotacion -= 1

