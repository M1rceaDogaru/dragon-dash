extends Node2D

export var speed = 0
export var camera_path: NodePath

var camera : Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_node(camera_path)

func _process(delta):
	for par_node in get_children():
		par_node.position = Vector2(par_node.position.x + speed * delta, par_node.position.y)
		if (par_node.position.x + 1088 < camera.global_position.x):
			par_node.position = Vector2(par_node.position.x + 1088 * 2, par_node.position.y)
		
