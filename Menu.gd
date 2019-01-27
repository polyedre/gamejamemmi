extends Control



func _on_Start_pressed():
	var murs = get_node("Murs")
	for c in murs.get_children():
		c.queue_free()
	
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene('res://World1.tscn')

	
func _on_Exit_pressed():
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().quit()

func _on_Start_mouse_entered():
	var sprite = get_node('Start/AnimatedSprite')
	sprite.play("selected") 
	pass # replace with function body


func _on_Start_mouse_exited():
	var sprite = get_node('Start/AnimatedSprite')
	sprite.play("default") 
	pass # replace with function body


func _on_Exit_mouse_entered():
	var sprite = get_node('Exit/AnimatedSprite')
	sprite.play("selected") 
	pass # replace with function body


func _on_Exit_mouse_exited():
	var sprite = get_node('Exit/AnimatedSprite')
	sprite.play("default") 
	pass # replace with function body
