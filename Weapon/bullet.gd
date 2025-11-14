extends Area3D

@export var speed: float = 60.0
@onready var damage: int

var velocity: Vector3


func _physics_process(delta: float) -> void:
	if velocity:
		global_position += velocity * delta

	# OPCIONAL: autocleanup
	if global_position.length() > 100:
		queue_free()


func _on_body_entered(body: Node3D) -> void:
	print(body.name)
	if body.is_in_group("enemy"):
		body.hitpoints -= damage
	queue_free()
	pass # Replace with function body.
