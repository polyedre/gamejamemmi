extends KinematicBody2D

const MOVE_SPEED = 600
const JUMP_FORCE = 1000
const GRAVITY = 50
const MAX_FALL_SPEED = 1000
const HORIZONTAL_ACCELERATION = 80
const HORIZONTAL_FRICTION = 0.95

onready var anim = $AnimatedSprite
var player
var nav2D

var mouse_over = 0
var grabbed = false
var taken = 0

export var flipped = false

func _ready():
	player = get_parent().get_node('Player')
	nav2D = get_node("Navigation2D")
	#print_tree()
	if flipped:
		flip(1)

var velocity = Vector2()
var direction = 0
var facing_right = false


var en_charge = false

func _physics_process(delta):

	if Input.is_action_pressed('right_click') and mouse_over:
		grabbed = true
		play_anim('grabbed')
	elif Input.is_action_just_released('right_click'):
		grabbed = false
		play_anim('idle')
	if grabbed:
		position = get_global_mouse_position()
	
	else:	
		velocity.y += GRAVITY
	
		if not en_charge:
			
			
			if abs(player.position.x - position.x) < 1000:
				en_charge = true
				if (player.position.x > position.x):
					velocity.x = MOVE_SPEED
					flip(1)
				else:
					velocity.x = -MOVE_SPEED
					flip(-1)
					
				play_anim("walk")
			
			
				
			
		else: # CHARGEEEEEEEEEZ !!
			if not velocity.x:
				en_charge = false
				play_anim("idle")

	velocity = move_and_slide(velocity, Vector2(0, -1))

func flip(x):
	if x == 1:
		facing_right = true
		anim.flip_h = true
	elif x == -1:
		facing_right = false
		anim.flip_h = false

func play_anim(anim_name):
	if anim.is_playing() and anim.animation == anim_name:
		return
	anim.play(anim_name)


func _on_Area2D_body_entered(body):
	if body.get_name() == 'Player':
		get_tree().change_scene('res://GameOver.tscn')


func _on_Area2D_mouse_entered():
	mouse_over = 1


func _on_Area2D_mouse_exited():
	mouse_over = 0
	
