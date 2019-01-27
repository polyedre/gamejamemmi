extends Camera2D

var is_triggered = false
onready var player = get_parent().get_node('Player')


func _on_Trigger_body_entered(body):
	if body.get_name() == 'Player':
		is_triggered = true
		make_current()

func _process(delta):
	if is_triggered:
		position.x += delta * 150
