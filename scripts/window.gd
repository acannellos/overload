extends NinePatchRect

@export var title: String

@onready var label = $Label
@onready var panel = $Panel

var is_mouse_pressed = false
var is_gui_clicked = false
var prev_mouse_pos: Vector2

var is_mouse_stopped = false

func _ready():
	label.text = title
	Events.connect("mouse_stopped", on_mouse_stopped)

func on_mouse_stopped():
	is_mouse_stopped = true

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			is_mouse_pressed = event.pressed
	
	if event is InputEventMouseButton and event.is_released():
		if event.button_index == MOUSE_BUTTON_LEFT:
			is_mouse_pressed = event.pressed
			is_gui_clicked = false
			prev_mouse_pos = Vector2.ZERO
			is_mouse_stopped = false

func _process(delta):
	if is_gui_clicked and not is_mouse_stopped:
		# Get the mouse motion
		var current_mouse_pos = get_global_mouse_position()
		
		if not prev_mouse_pos:
			prev_mouse_pos = current_mouse_pos
		var mouse_motion = current_mouse_pos - prev_mouse_pos

		# Move the NinePatchRect by the mouse motion
		position += mouse_motion
		prev_mouse_pos = current_mouse_pos	
	
	#prev_mouse_pos = Vector2.ZERO
	#is_mouse_pressed = false

func _on_panel_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			var parent = get_parent()
			parent.remove_child(self)
			parent.add_child(self)
			is_gui_clicked = true
			
			#is_mouse_pressed = event.pressed
			#if is_mouse_pressed:
				## Bring the NinePatchRect to the front when the mouse button is pressed
				#var parent = get_parent()
				#parent.remove_child(self)
				#parent.add_child(self)
			#else:
				#prev_mouse_pos = Vector2.ZERO
				#is_mouse_pressed = false
				## Handle the case when the left mouse button is released
				## For example, you can perform any cleanup or additional actions here
				#pass


func _on_texture_button_pressed():
	visible = false
