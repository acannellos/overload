extends NinePatchRect

@export var task_datas: Array[TaskData]
var window_key = "email"

@onready var label = $Label
@onready var panel = $Panel
@onready var task_list = $task_list
@onready var count_label = $count_label

var is_gui_clicked = false
var prev_mouse_pos: Vector2

func _ready():
	Events.connect("shortcut_clicked", on_shortcut_clicked)
	update_count_label()
	#count_label.text = "0/" + str(task_datas.size())

func on_shortcut_clicked(key):
	#print(key)
	if key == window_key:
		visible = not visible
		var parent = get_parent()
		parent.remove_child(self)
		parent.add_child(self)

func _input(event):	
	if event is InputEventMouseButton and event.is_released():
		if event.button_index == MOUSE_BUTTON_LEFT:
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
	Events.close_clicked.emit(window_key)
	visible = false

func _on_timer_timeout():
	var count = 0
	for task in task_datas:
		if not task:
			var new_task_data = TaskData.new()
			new_task_data.category = Enums.EmployeeType.GREEN
			task_datas[count] = new_task_data
			task_list.populate_task_list(task_datas)
			update_count_label()
			return
		count += 1
	
	#
	#var current_count = count_tasks()
	#if current_count <= 3:
		#var new_task_data = TaskData.new()
		#new_task_data.category = Enums.EmployeeType.GREEN
		#task_datas[current_count] = new_task_data
		#task_list.populate_task_list(task_datas)
		#update_count_label()
		
		#var new_count = count_tasks()
		#count_label.text = str(new_count + 1) + "/" + str(task_datas.size())

func count_tasks() -> int:
	var count: int = 0
	for task in task_datas:
		if task:
			count += 1
	return count

func update_count_label():
	var count = count_tasks()
	count_label.text = str(count) + "/" + str(task_datas.size())
