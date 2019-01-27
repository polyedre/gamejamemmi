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
var taken = 0

func _ready():
	player = get_node("../Player")
	nav2D = get_node("Navigation2D")
	
	#print_tree()
	
var velocity = Vector2()
var direction = 0
var facing_right = false


var en_charge = false


func _physics_process(delta):

	var point_near
	if (player):
		point_near = nav2D.get_closest_point(player.position)
		if (player.position.x > position.x): flip(1)
		elif (player.position.x < position.x): flip(-1)
	
		else:
			velocity.x *= (abs(velocity.x) / MOVE_SPEED) * 0.95
	
	velocity = move_and_slide(point_near, Vector2(0, -1))
	
	var grounded = is_on_floor()
	velocity.y += GRAVITY

	if not en_charge:
		
		# Perso vu à droite
		if (player.position.x > position.x && anim.flip_h):
			if abs(player.position.x - position.x) < 5000:
				en_charge = true
				velocity.x = MOVE_SPEED
		
		if (player.position.x < position.x && !anim.flip_h):
			if abs(player.position.x - position.x) < 5000:
				en_charge = true
				velocity.x = -MOVE_SPEED
		
	else: # CHARGEEEEEEEEEZ !!
		velocity = move_and_slide(velocity, Vector2(0, -1))
		if not velocity.x:
			en_charge = false


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


func _on_Ennemi_mouse_entered():
	mouse_over = 1
	pass # replace with function body
	print("entrou") 


func _on_Ennemi_mouse_exited():
	mouse_over = 0
	pass # replace with function body
