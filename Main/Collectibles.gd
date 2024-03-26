extends Node2D

var collectible = preload("res://Collectible/Collectible.tscn")
export var camera_path: NodePath
export var min_position = 0
export var max_position = 500

var collectibles = []

var camera : Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Score.start()
	camera = get_node(camera_path)
	for par_node in get_children():
		spawn(par_node)
	
func _process(delta):
	get_parent().get_node("Dragon/Camera2D/Score").text = str(int(Score.current_score))
	for par_node in get_children():
		if (par_node.position.x + 1088 < camera.global_position.x):
			par_node.position = Vector2(par_node.position.x + 1088 * 2, par_node.position.y)
			spawn(par_node)
			
	for col in collectibles:
		if !is_instance_valid(col):
			collectibles.erase(col)
		elif col.position.x + 1088 < camera.global_position.x:
			collectibles.erase(col)
			col.queue_free()

func spawn(point):
	var new_collectible = collectible.instance()
	new_collectible.position = Vector2(point.position.x, int(rand_range(min_position, max_position)))
	collectibles.append(new_collectible)
	call_deferred("add", new_collectible)
	
func add(col):
	get_parent().add_child(col)
