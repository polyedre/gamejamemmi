extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _physics_process(delta):
	var colliders = get_overlapping_bodies()
	
	for c in colliders:
		if c.name == 'Player':
			get_parent().get_parent().inc_ink()
			queue_free()
			
 