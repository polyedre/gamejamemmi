extends KinematicBody2D

const MOVE_SPEED = 500
const JUMP_FORCE = 1000
const GRAVITY = 50
const MAX_FALL_SPEED = 1000
const HORIZONTAL_SPEED_LIMIT = 1000
const HORIZONTAL_ACCELERATION = 20
const HORIZONTAL_FRICTION = 0.95

onready var anim_player = $AnimationPlayer
onready var sprite = $Sprite

var velocity = Vector2()
var facing_right = false


func _physics_process(delta):
	var move_dir = 0
	if Input.is_action_pressed("move_right"):
		velocity.x = min(velocity.x + HORIZONTAL_ACCELERATION,
		HORIZONTAL_SPEED_LIMIT)  
		move_dir = 1
	if Input.is_action_pressed("move_left"):
		velocity.x = max(velocity.x - HORIZONTAL_ACCELERATION,
		- HORIZONTAL_SPEED_LIMIT)
		move_dir = -1
	
	velocity.x *= HORIZONTAL_FRICTION
	
	move_and_slide(velocity)
	
	var grounded = is_on_floor()
	velocity.y += GRAVITY
	if grounded and Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP_FORCE
	if grounded and velocity.y >= 0:
		velocity.y = 5
	if velocity.y > MAX_FALL_SPEED:
		velocity.y = MAX_FALL_SPEED
	
	if is_on_wall() and not is_on_floor(): #Collé à un mur
		velocity = Vector2(0,0)
		if Input.is_action_pressed("jump"):
			if velocity.x > 0:
				velocity = Vector2(-1000, -1000)
				print(">")
			else:
				print("<")
				velocity = Vector2(1000, -1000)

	if grounded:
		if move_dir == 0:
			play_anim("idle")
		else:
			play_anim("walk")
	else:
		play_anim("jump")

func flip():
	facing_right = !facing_right
	sprite.flip_h = !sprite.flip_h

func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)