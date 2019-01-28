extends Camera2D

var is_triggered = false
onready var player = get_parent().get_node('Player')


func _on_Trigger_body_entered(body):
	if body.get_name() == 'Player':
		is_triggered = true
		position = player.position
		make_current()

func _process(delta):
	if is_triggered:
		position.x += delta * 150	
	if player.position.x + 300 < get_camera_position().x - get_viewport().get_visible_rect().size.x / 2:
		get_tree().change_scene('res://GameOver.tscn')
		
