extends NinePatchRect

@onready var label = $Label
@onready var panel = $Panel

var is_gui_clicked = false
var prev_mouse_pos: Vector2

func _ready():
	Events.connect("shortcut_clicked", on_shortcut_clicked)

func on_shortcut_clicked(key):
	if key == "budget":
		visible = not visible
		var parent = get_parent()
		parent.remove_child(self)
		parent.add_child(self)

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			#is_mouse_pressed = event.pressed
			pass
	
	if event is InputEventMouseButton and event.is_released():
		if event.button_index == MOUSE_BUTTON_LEFT:
			#is_mouse_pressed = event.pressed
			is_gui_clicked = false
			prev_mouse_pos = Vector2.ZERO
			modulate = Color(1,1,1,1)

func _process(delta):
	if is_gui_clicked:
		var current_mouse_pos = get_global_mouse_position()
		
		if not prev_mouse_pos:
			prev_mouse_pos = current_mouse_pos
		
		var mouse_motion = current_mouse_pos - prev_mouse_pos
		position += mouse_motion
		prev_mouse_pos = current_mouse_pos	

func _on_panel_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			var parent = get_parent()
			parent.remove_child(self)
			parent.add_child(self)
			is_gui_clicked = true
			modulate = Color(1,1,1,0.7)

func _on_texture_button_pressed():
	visible = false
