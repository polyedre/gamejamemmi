extends Control

var _pen = null
var _prev_mouse_pos = Vector2()
var _line_points = Array()

func _ready():
	var viewport = Viewport.new()
	var rect = get_rect()
	viewport.size = rect.size
	viewport.usage = Viewport.USAGE_2D
	# Note: I also tried CLEAR_MODE_NEVER but it doesn't draw anything.
	# (see issue https://github.com/godotengine/godot/issues/20775)
	viewport.render_target_clear_mode = Viewport.CLEAR_MODE_ONLY_NEXT_FRAME
	viewport.render_target_v_flip = true

	_pen = Node2D.new()
	viewport.add_child(_pen)
	_pen.connect("draw", self, "_on_draw")

	add_child(viewport)

	# Use a sprite to display the result texture
	var rt = viewport.get_texture()
	var board = TextureRect.new()
	board.set_texture(rt)
	add_child(board)


func _process(delta):
	_pen.update()
	if Input.is_action_just_released("click"):
		var line = Line2D.new()
		var body = create_body(_line_points[0])
		var length = _line_points.size()
		
		for i in range(length-1):
			create_collider(_line_points[i], _line_points[i+1], body)
			line.add_point(_line_points[i])
			line.add_point(_line_points[i+1])
			


		_line_points.clear()
		#line.set_color(Color(0,0,0))
		line.set_width(5)
		add_child(line)
		


func _on_draw():
	var mouse_pos = get_local_mouse_position()
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		_pen.draw_line(mouse_pos, _prev_mouse_pos, Color(0, 0, 0), 3, true)
		_line_points.append(mouse_pos)

	_prev_mouse_pos = mouse_pos

func create_body(pos):
	var rigidbody = StaticBody2D.new()
	add_child(rigidbody)
	print("rigidbody foi")
	return rigidbody

func create_collider(start, end, body):
	var shape = SegmentShape2D.new()
	var collider = CollisionShape2D.new()
	shape.a = start
	shape.b = end
	collider.set_shape(shape)
	body.add_child(collider)
