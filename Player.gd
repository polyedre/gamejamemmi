extends KinematicBody2D

const MOVE_SPEED = 600
const JUMP_FORCE = 1000
const GRAVITY = 50
const MAX_FALL_SPEED = 1000
const HORIZONTAL_ACCELERATION = 80
const HORIZONTAL_FRICTION = 0.95

onready var sprite = $AnimatedSprite
#onready var sprite = $Sprite

var velocity = Vector2()
var facing_right = false


func _physics_process(delta):
	var move_dir = 0
	if Input.is_action_pressed("move_right"):
		velocity.x = min(velocity.x + HORIZONTAL_ACCELERATION,
		MOVE_SPEED)  
		flip(1)
	elif Input.is_action_pressed("move_left"):
		velocity.x = max(velocity.x - HORIZONTAL_ACCELERATION,
		- MOVE_SPEED)
		flip(-1)
	
	else:
		velocity.x *= (abs(velocity.x) / MOVE_SPEED) * 0.95
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	var grounded = is_on_floor()
	velocity.y += GRAVITY
	if grounded and Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP_FORCE
	if grounded and velocity.y >= 0:
		velocity.y = 5
	if velocity.y > MAX_FALL_SPEED:
		velocity.y = MAX_FALL_SPEED


	if grounded:
		if move_dir == 0:
			play_anim("idle")
		else:
			play_anim("walk")
	else:
		play_anim("jump")

func flip(x):
	if x==1:
		facing_right = true
		sprite.flip_h = true
	elif x == -1:
		facing_right = false
		sprite.flip_h = false

func play_anim(anim_name):
	if sprite.is_playing() and sprite.animation == anim_name:
		return
	sprite.play(anim_name)
