extends NinePatchRect

@export var task_datas: Array[TaskData]
@export var Task: PackedScene

@export var title: String

@onready var label = $Label
@onready var panel = $Panel
@onready var task_list = $task_list
@onready var count_label = $count_label

#var is_mouse_pressed = false
var is_gui_clicked = false
var prev_mouse_pos: Vector2

func _ready():
	#label.text = title
	Events.connect("shortcut_clicked", on_shortcut_clicked)
	count_label.text = "0/" + str(task_datas.size())

func on_shortcut_clicked(key):
	print(key)
	if key == "email":
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
	Events.close_clicked.emit("email")
	visible = false


func _on_timer_timeout():
	print("timeout")
	var count: int = 0
	for task in task_datas:
		if task:
			count += 1
	
	if count <= 3:
		print(count)
		var new_task = TaskData.new()
		new_task.category = Enums.EmployeeType.GREEN
		task_datas[count] = new_task
		task_list.populate_task_list(task_datas)
		count_label.text = str(count + 1) + "/" + str(task_datas.size())
	#var task = Task.instantiate()
	#task_list.add_child(task)
	#count_label.text = "0/" + str(task_datas.size())
