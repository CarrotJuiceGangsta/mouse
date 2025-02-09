extends Node2D

var selected = false
var rest_point = Vector2()
var rest_nodes = []
var items = []
var interactive = []
var filled
var item = preload("res://world/world.tscn")
@export var item_type = ""
func _ready():
	rest_nodes = get_tree().get_nodes_in_group("zone")
	items = get_tree().get_nodes_in_group("items")
	interactive = get_tree().get_nodes_in_group("interactive")
	print(item_type)
	for child in rest_nodes:
		if child.full == false:
			rest_point = child.global_position
			filled = child
			child.select()
			
			break
	
func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
#		look_at(get_global_mouse_position())
	else:
		global_position = lerp(global_position, rest_point, 10 * delta)
#		rotation = lerp_angle(rotation, 0, 10 * delta)
		


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("interact"):
		selected = true



func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
			var shortest_dist = 75
			for child in rest_nodes:
				var distance = global_position.distance_to(child.global_position)
				if distance < shortest_dist == true and child.full == false:
					filled.full = false
					filled = child
					child.full == true
					child.select()
					rest_point = child.global_position
					shortest_dist = distance
			for baby in interactive:
				if baby != null:
					var dist = global_position.distance_to(baby.global_position)
					if dist < shortest_dist and item_type == "abab":
						print("you got me. I'm abab")
						var instance = item.instantiate()
						#get_tree().change_scene_to_file("res://level_2.tscn")
#						$".".queue_free()
						baby.queue_free()
						add_child(instance)
						instance.add_to_group("items")
				else:
					break
