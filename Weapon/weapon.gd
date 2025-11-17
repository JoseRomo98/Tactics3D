extends Node3D

@export var bullet_scene: PackedScene

@export var damage: int = 10
@export var burst_size: int = 5
@export var delay: float = 0.4

@onready var barrel_location: Node3D = $BarrelLocation

func shoot(target: Vector3) -> void:
	if bullet_scene == null:
		push_error("No bullet_scene assigned!")
		return

	# Crear instancia de la bala
	var bullet = bullet_scene.instantiate()
	bullet.damage = damage
	
	# Agregar bala instanciada al arbol
	get_tree().current_scene.add_child(bullet)
	
	var origin = barrel_location.global_position
	bullet.global_position = origin

	var dir = (target - origin).normalized()
	bullet.velocity = dir * bullet.speed
	
	# Posicionar la bala en el cañón
	#bullet.global_transform.origin = barrel_location.global_transform.origin
	
	# Calcular dirección hacia el objetivo
	#var dir = (target - bullet.global_transform.origin).normalized()
	
	# Orientar la bala hacia la dirección
	#bullet.look_at(target, Vector3.UP)
	
	# Configurar velocidad (si la bala usa velocity en su script)
	#bullet.velocity = dir * bullet.speed  # speed: export en la bala
