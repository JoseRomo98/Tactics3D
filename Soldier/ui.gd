extends MarginContainer

var current_soldier: CharacterBody3D

@onready var health_bar: ProgressBar = %HealthBar
@onready var energy_bar: ProgressBar = %EnergyBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#energy_bar.value = current_soldier.movement_manager.energy
	pass # Replace with function body.

func load_soldier_info() -> void:
	energy_bar.value = current_soldier.movement_manager.energy
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_soldier != null:
		if current_soldier.is_moving:
			energy_bar.value = current_soldier.movement_manager.use_energy()
	pass
