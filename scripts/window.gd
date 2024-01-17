extends NinePatchRect

#enum WindowType{
	#EMPLOYEE,
	#EMAIL,
#}
#
#@export var type = WindowType.EMPLOYEE
#@export var employee: EmployeeData
@export var task_datas: Array[TaskData]

@export var title: String

@onready var label = $Label
@onready var panel = $Panel

var is_mouse_pressed = false
var is_gui_clicked = false
var prev_mouse_pos: Vector2

func _ready():
	label.text = title

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			is_mouse_pressed = event.pressed
	
	if event is InputEventMouseButton and event.is_released():
		if event.button_index == MOUSE_BUTTON_LEFT:
			is_mouse_pressed = event.pressed
			is_gui_clicked = false
			prev_mouse_pos = Vector2.ZERO

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

func _on_texture_button_pressed():
	visible = false
