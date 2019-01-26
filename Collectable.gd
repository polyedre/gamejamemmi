extends Area2D

export var next_scene = ""

func _physics_process(delta):
	var colliders = get_overlapping_bodies()
	
	for c in colliders:
		if c.name == 'Player':
			get_tree().change_scene(next_scene)