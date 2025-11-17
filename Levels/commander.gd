extends Node3D

#Nodo3D que contiene los soldados aliados
@export var allies: Node3D
@export var start_actions: int = 5


@onready var soldier_ui: MarginContainer = $SoldierUI
@onready var actions_counter: Label = $TurnUI/ActionsCounter


var actions_left: int = start_actions:
	set(value):
		actions_left = value
		actions_counter.text = "Actions Left: " + str(value)
		if value == 0:
			#ToDo: End Turn
			pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	select_soldier(allies.get_child(0))
	actions_left = start_actions
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("next"):
		next_soldier()
	
	if Input.is_action_just_pressed("prev"):
		previus_soldier()
	pass

func select_soldier(active_soldier: CharacterBody3D) -> void:
	for soldier in allies.get_children():
		if soldier == active_soldier:
			#Manipular variables de estado
			soldier.is_select = true
			
			#Manipular camaras
			soldier.camera_3d.current = true
			soldier.aim_camera.current = false
			print(soldier.position)
			position = soldier.position
			#soldier.set_process(true)
			
			soldier_ui.current_soldier = soldier
			soldier_ui.load_soldier_info()
			
		else:
			soldier.is_select = false
			soldier.camera_3d.current = false
			soldier.aim_camera.current = false

func next_soldier() -> void: 
	var index = get_current_index()
	index = wrapi(index +1, 0, allies.get_child_count())
	select_soldier(allies.get_child(index))
	
func previus_soldier() -> void: 
	var index = get_current_index()
	index = wrapi(index -1, 0, allies.get_child_count())
	select_soldier(allies.get_child(index))

func get_current_index() -> int:
	for index in allies.get_child_count():
		if allies.get_child(index).is_select == true:
			return index
	return 0
