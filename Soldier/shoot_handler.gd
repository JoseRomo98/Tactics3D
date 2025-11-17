extends Node3D

@onready var aim_camera: Camera3D = %AimCamera
@onready var weapon_mesh: Node3D = $WeaponMesh
@onready var soldier: CharacterBody3D = $"../../.."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _unhandled_input(event: InputEvent) -> void:		
	if soldier.is_aiming:
		if Input.is_action_just_pressed("main_action"):
			fire_burst()

func fire_burst() -> void:
	soldier.is_firing = true
	for n in weapon_mesh.burst_size:
		weapon_mesh.shoot(aim_camera.get_impact(1000))
		await get_tree().create_timer(weapon_mesh.delay).timeout

	soldier.is_firing = false
