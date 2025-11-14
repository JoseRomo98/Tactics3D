@tool
extends Control


func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)

func _draw() -> void:
		##Circulo central
	#draw_circle(Vector2.ZERO,40,Color.DARK_ORANGE,false,-1)
	#draw_circle(Vector2.ZERO,40,Color.DARK_ORANGE,false,-1)
	#
	##Lineas
	#draw_line(Vector2(8,0),Vector2(14,0),Color.DARK_RED,2)
	#draw_line(Vector2(-8,0),Vector2(-14,0),Color.DARK_RED,2)
	#draw_line(Vector2(0,8),Vector2(0,14),Color.DARK_RED,2)
	#draw_line(Vector2(0,-8),Vector2(0,-14),Color.DARK_RED,2)

	print(size)
	var center = size / 2
	var radius = min(size.x, size.y) * 0.05  # 5% del lado menor

	# Círculo central
	draw_circle(center, radius, Color.DARK_ORANGE,false)

	# Líneas
	var gap = radius * 0.2
	var line_len = radius * 0.3
	var color = Color.DARK_RED
	var thick = 2.0

	draw_line(center + Vector2(gap, 0), center + Vector2(line_len, 0), color, thick)
	draw_line(center + Vector2(-gap, 0), center + Vector2(-line_len, 0), color, thick)
	draw_line(center + Vector2(0, gap), center + Vector2(0, line_len), color, thick)
	draw_line(center + Vector2(0, -gap), center + Vector2(0, -line_len), color, thick)
