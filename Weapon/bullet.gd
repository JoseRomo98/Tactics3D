extends Area3D

@export var speed: float = 60.0
@onready var damage: int

var velocity: Vector3

var previous_position: Vector3

func _ready():
	previous_position = global_position

func _physics_process(delta):
	var new_position = global_position + velocity * delta

	var space = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(global_position, new_position)
	query.collide_with_areas = false
	query.collide_with_bodies = true

	var hit = space.intersect_ray(query)

	if hit:
		on_hit(hit)
		return

	global_position = new_position
	previous_position = new_position

func on_hit(hit):
	var collider = hit.collider
	# aplicar daño, efectos, partículas...
	if collider.is_in_group("enemy"):
		collider.hitpoints -= damage
	
	print(collider)
	queue_free()

#func _physics_process(delta: float) -> void:
	#if velocity:
		#global_position += velocity * delta
	
	# OPCIONAL: autocleanup
	#if global_position.length() > 100:
		#queue_free()


#func _on_body_entered(body: Node3D) -> void:
	#print(body.name)
	#if body.is_in_group("enemy"):
		#body.hitpoints -= damage
	#
	#queue_free()

#func _on_area_entered(area: Area3D) -> void:
	#print("Area: " + area.name)
	#pass # Replace with function body.
