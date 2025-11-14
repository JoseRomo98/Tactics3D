extends CharacterBody3D

@export var sensitivity: float = 0.001
@export var tilt_limit: float = deg_to_rad(60)
@export var weapon: PackedScene 

@onready var camera_3d: Camera3D = %Camera3D
@onready var camera_pivot: Node3D = %CameraPivot

@onready var movement_manager: Node = $MovementManager
@onready var cross_hair: Control = $CameraPivot/AimCamera/CrossHair


@onready var mesh: MeshInstance3D = $Mesh
@onready var shoot_position: Node3D = $ShootPosition
@onready var aim_camera: Camera3D = %AimCamera

#@onready var weapon_mesh: Node3D = $Mesh/WeaponMesh
var is_firing: bool = false
var is_aiming: bool = false
var is_moving: bool = false
var is_active: bool = false

@onready var weapon_mesh: Node3D = $CameraPivot/AimCamera/ShootHandler/WeaponMesh


const SPEED = 5.0
const JUMP_VELOCITY = 4.5


var mouse_motion: Vector2 = Vector2.ZERO
var aiming_point: Vector3 = Vector3.ZERO


func _physics_process(delta: float) -> void:
	if !is_active:
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir := Input.get_vector("move_left", "move_right", "move_foward", "move_back")
	
	#Leer direccion del Inpur
	var input_dir := Input.get_vector("move_left", "move_right", "move_foward", "move_back")
	
	#Calcular Direccion
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	#Definir Direccion a donde ve la camara
	direction = direction.rotated(Vector3.UP,camera_3d.global_rotation.y)
	
	if direction:
		is_moving = true
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		#lerp(global_transform.origin, global_transform.origin + direction,0.5)
		#mesh.look_at((global_transform.origin + direction), Vector3.UP)
		var target_yaw = atan2(-direction.x, -direction.z)
		mesh.rotation.y = lerp_angle(mesh.rotation.y, target_yaw, 0.6)
		
		if movement_manager.use_energy() <= 0:
			is_moving = false
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
		
	else:
		is_moving = false
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	
	move_and_slide()

func _process(delta: float) -> void:
	pass
	#if is_aiming:
		#if Input.is_action_just_pressed("main_action"):
			#weapon_mesh.shoot(aim_camera.get_impact(1000))
			#print(aim_camera.get_random_shot_direction())

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera_3d.current = true

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_motion = -event.relative * sensitivity

func _unhandled_input(event: InputEvent) -> void:
	
	if !is_active:
		return
	
	if event is InputEventMouseMotion:
		
		if is_firing:
			return
		
		if is_aiming:
			# Yaw soldado
			rotation.y += -event.relative.x * sensitivity
			
			# Rotar en x arma
			weapon_mesh.rotation.x += -event.relative.y * sensitivity
			
			camera_pivot.rotation.x -= event.relative.y * sensitivity
			# Prevenir la camara rote ilimitadamente alrededor del jugador
			camera_pivot.rotation.x = clampf(camera_pivot.rotation.x, -tilt_limit, tilt_limit)
			return
		
		camera_pivot.rotation.x -= event.relative.y * sensitivity
		# Prevenir la camara rote ilimitadamente alrededor del jugador
		camera_pivot.rotation.x = clampf(camera_pivot.rotation.x, -tilt_limit, tilt_limit)
		camera_pivot.rotation.y += -event.relative.x * sensitivity
	
	if Input.is_action_just_pressed("secondary_action"):
		manage_aiming()

func manage_aiming() -> void:
	is_aiming = !is_aiming
	camera_pivot.rotation.x = 0
	#mesh.look_at(-aim_camera.get_global_transform().basis.z)
	if is_aiming:
		
		#Obtener direccion de enfrente de la camara
		var camera_forward_direction: Vector3 = -aim_camera.global_transform.basis.z
		
		#calcular direccion objetivo
		var target_position: Vector3 = mesh.global_transform.origin + camera_forward_direction
		
		
		#target_position.y = mesh.global_transform.origin.y
		
		#Hacer que el modelo gire a la direccion objetivo
		mesh.look_at(target_position, Vector3.UP)
		aim_camera.current = true
		cross_hair.visible = true
		
		camera_3d.current = false
	else:
		aim_camera.current = false
		cross_hair.visible = false
		
		camera_3d.current = true
	
