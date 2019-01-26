extends Control

var _pen = null
var _prev_mouse_pos = Vector2()
var drawings = Array()
var paint_texture = preload("res://paint.png")

var available_paint
var player

const PAINT_WIDTH = 5
const INITIAL_PAINT = 100


class Drawing:

	var body
	var ttl
	var line
	var root

	func _init(staticbody, parent, line):
		body = staticbody
		ttl = 150
		root = parent
		self.line = line

	func decTime():
		ttl = ttl-1
		if ttl == 0:
			root.remove_child(body)
			root.remove_child(line)
			return 1
		return 0

func _ready():
	available_paint = INITIAL_PAINT

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

	for d in drawings:
		if d.decTime() == 1:
			drawings.erase(d)




func _on_draw():
	var mouse_pos = get_local_mouse_position()
	if Input.is_mouse_button_pressed(BUTTON_LEFT) && available_paint > 0:
		#_line_points.append(mouse_pos)
		available_paint = available_paint-1
		draw_segment(mouse_pos)

	_prev_mouse_pos = mouse_pos

func draw_segment(mouse_pos):
	var line = Line2D.new()
	line.default_color = Color(0,0,0)
	line.set_width(PAINT_WIDTH)
	line.set_texture(paint_texture)
	line.set_texture_mode(1)

	var body = create_body(_prev_mouse_pos)


	create_collider(_prev_mouse_pos, mouse_pos, body)
	line.add_point(_prev_mouse_pos)
	line.add_point(mouse_pos)


	var drawing = Drawing.new(body, self, line)
	drawings.append(drawing)

	add_child(line)

func create_body(pos):
	var rigidbody = StaticBody2D.new()
	add_child(rigidbody)
	return rigidbody

func create_collider(start, end, body):
	var shape = SegmentShape2D.new()
	var collider = CollisionShape2D.new()
	shape.a = start
	shape.b = end
	collider.set_shape(shape)
	body.add_child(collider)


func inc_ink():
	available_paint = available_paint+25