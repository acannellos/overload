extends Node
class_name WindowComponent

@export var window_key = "default"

var parent
var gparent
var is_gui_clicked = false
var prev_mouse_pos: Vector2

func _ready():
	Events.connect("shortcut_clicked", on_shortcut_clicked)
	call_deferred("handle_ready")
	
func handle_ready():
	parent = get_parent()
	gparent = parent.get_parent()

func on_shortcut_clicked(key):
	if key == window_key:
		parent.visible = not parent.visible
		gparent.remove_child(parent)
		gparent.add_child(parent)

func _input(event):	
	if event is InputEventMouseButton and event.is_released():
		if event.button_index == MOUSE_BUTTON_LEFT:
			is_gui_clicked = false
			prev_mouse_pos = Vector2.ZERO
			parent.modulate = Color(1,1,1,1)

func _process(delta):
	if is_gui_clicked:
		var current_mouse_pos = parent.get_global_mouse_position()
		
		if not prev_mouse_pos:
			prev_mouse_pos = current_mouse_pos
		
		var mouse_motion = current_mouse_pos - prev_mouse_pos
		parent.position += mouse_motion
		prev_mouse_pos = current_mouse_pos	

func _on_panel_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			gparent.remove_child(parent)
			gparent.add_child(parent)
			is_gui_clicked = true
			parent.modulate = Color(1,1,1,0.7)

func _on_button_close_pressed():
	Events.close_clicked.emit(window_key)
	parent.visible = false
