extends Camera3D

@export var spread_radius: float = 0.02 # metros

func get_random_shot_direction() -> Vector3:
	# 1. Dirección base (hacia donde apunta la cámara)
	var forward = -global_transform.basis.z.normalized()

	# 2. Generar punto aleatorio dentro de un círculo en 2D
	var angle = randf() * TAU
	var r = sqrt(randf()) * spread_radius  # sqrt para distribución uniforme
	var offset_2d = Vector2(cos(angle), sin(angle)) * r

	# 3. Convertir ese punto 2D a un desplazamiento en el plano de la cámara
	var right = global_transform.basis.x
	var up = global_transform.basis.y
	var offset_3d = (right * offset_2d.x) + (up * offset_2d.y)

	# 4. Combinar la dirección con el desplazamiento
	var final_dir = (forward + offset_3d).normalized()
	return final_dir

func get_impact(range:int) -> Vector3:
	var direction: Vector3 = get_random_shot_direction()
	var origin: Vector3 = global_position
	var destination: Vector3 = origin + (direction * range)

	var space_state = get_world_3d().direct_space_state
		
	var ray_origin = global_transform.origin
	var ray_end = destination
	
	var query = PhysicsRayQueryParameters3D.new()
	query.from = ray_origin
	query.to = ray_end
	query.collide_with_areas = false
	query.collide_with_bodies = false
	var result = space_state.intersect_ray(query)

	if result.size() > 0:
		# --- DEBUG INFO ---
		#print("Hit at:", result.position)
		#print("Hit normal:", result.normal)
		#print("Hit collider:", result.collider)
		#print("Hit collider name:", result.collider.name)
		# -------------------
		
		return result.position
	else:
		# No colisionó con nada
		#print("No hit. End point:", destination)
		return destination
