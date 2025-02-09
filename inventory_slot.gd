extends Marker2D


@export var full = false
@export var item = ""
var shortest_dist = 75

func _draw():
	draw_circle(Vector2.ZERO, 75, Color.TRANSPARENT)
	modulate.a = 0.05
	
func select():
	for child in get_tree().get_nodes_in_group("zone"):
		if child.full:
			pass
		else:
			child.deselect()
	modulate = Color.WEB_MAROON
	modulate.a = 0.05
	full = true

	
func deselect():
	modulate = Color.WHITE
	modulate.a = 0.05
	full = false



