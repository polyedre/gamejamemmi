extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var mouse_over = 0
export var state = 0
var inside_spikes = 0
var shape
var sprite

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	sprite = get_node("AnimatedSprite")
	shape = get_node("Regular")
	pass


func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		state = 1-state
		if (state == 0):
			sprite.play("default")
		else:
			sprite.play("spiked")
			if inside_spikes:
				get_tree().change_scene('res://GameOver.tscn')	

	pass # replace with function body


func _on_Spikes_body_entered(body):
	print("entrou")
	if body.name == "Player":
		inside_spikes = 1
		if state == 1:
			get_tree().change_scene('res://GameOver.tscn')
	pass # replace with function body


func _on_Spikes_body_exited(body):
	if body.name == "Player":
		inside_spikes = 0
	pass # replace with function body
