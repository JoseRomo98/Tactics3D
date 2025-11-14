extends MarginContainer

@onready var soldier: CharacterBody3D = $".."
@onready var energy_bar: ProgressBar = $EnergyBar
@onready var movement_manager: Node = $"../MovementManager"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	energy_bar.value = movement_manager.energy
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if soldier.is_moving:
		energy_bar.value = movement_manager.use_energy()
	pass
