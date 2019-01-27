extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass


func _on_Button_pressed():
	get_tree().change_scene('res://World1.tscn')
	pass # replace with function body


func _on_Quit_pressed():
	get_tree().quit()
	pass # replace with function body
