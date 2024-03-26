extends Node2D

export var camera_path: NodePath
export var min_position = 174
export var max_position = 390

var camera : Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_node(camera_path)
	for par_node in get_children():
		initialize(par_node)
	
func _process(delta):
	for par_node in get_children():
		if (par_node.position.x + 1088 < camera.global_position.x):
			par_node.position = Vector2(par_node.position.x + 1088 * 2, par_node.position.y)
			initialize(par_node)
			
func initialize(obstacle):
	obstacle.position.y = int(rand_range(min_position, max_position))
