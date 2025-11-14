extends Node

@export var energy: float = 100.0

var energy_consume: float = 0.5

func use_energy() -> float:
	if energy <= 0:
		return 0
	
	energy -= energy_consume
	print(energy)
	return energy
