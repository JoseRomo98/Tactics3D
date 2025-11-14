extends Node

@export var turns: int = 5
@onready var allies: Node3D = $Allies

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var allies_list: Array = allies.get_children()
	
	print(allies_list)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
