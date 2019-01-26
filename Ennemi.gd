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

func _ready():
	player = get_node("../Player")
	nav2D = get_node("Navigation2D")
	
	#print_tree()
	
var velocity = Vector2()
var direction = 0
var facing_right = false

func _physics_process(delta):

	#print(player)
	if (player):
		var point_near = nav2D.get_closest_point(player.position)
#	if Input.is_action_pressed("move_right"):
#		velocity.x = min(velocity.x + HORIZONTAL_ACCELERATION,
#		MOVE_SPEED)  
#		direction = 1
#		flip(1)
#	elif Input.is_action_pressed("move_left"):
#		velocity.x = max(velocity.x - HORIZONTAL_ACCELERATION,
#		- MOVE_SPEED)
#		direction = -1
#		flip(-1)
		if (player.position.x > position.x): flip(1)
		elif (player.position.x < position.x): flip(-1)
	
		else:
			velocity.x *= (abs(velocity.x) / MOVE_SPEED) * 0.95
	
		velocity = move_and_slide(point_near, Vector2(0, -1))
	
	var grounded = is_on_floor()
	velocity.y += GRAVITY
	if grounded and Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP_FORCE
	if grounded and velocity.y >= 0:
		velocity.y = 5
	if velocity.y > MAX_FALL_SPEED:
		velocity.y = MAX_FALL_SPEED


#	if grounded:
#		if move_dir == 0:
	play_anim("idle")
#		else:
#			play_anim("walk")
#	else:
#		play_anim("jump")

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

