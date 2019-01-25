extends Control

var _pen = null
var _prev_mouse_pos = Vector2()


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


func _on_draw():
    var mouse_pos = get_local_mouse_position()

    if Input.is_mouse_button_pressed(BUTTON_LEFT):
        _pen.draw_line(mouse_pos, _prev_mouse_pos, Color(0, 0, 0), 3)

    _prev_mouse_pos = mouse_pos
