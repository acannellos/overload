extends NinePatchRect

@export var employee: EmployeeData
@export var task_datas: Array[TaskData]

@export_group("textures")
@export var tex_player: CompressedTexture2D
@export var tex_green: CompressedTexture2D
@export var tex_blue: CompressedTexture2D
@export var tex_violet: CompressedTexture2D
@export var tex_magenta: CompressedTexture2D

@onready var label = $Label
@onready var panel = $Panel
@onready var type = $type
@onready var task_list = $task_list
@onready var count_label = $count_label

@onready var overload_bar = $overload_bar
var is_overloaded: bool = false

var is_gui_clicked = false
var prev_mouse_pos: Vector2

func _ready():
	if employee:
		label.text = employee.name
	set_employee_texture()
	
	if not employee.type == Enums.EmployeeType.PLAYER:
		size.y = 300
	
	count_label.text = "0/" + str(task_datas.size())
	
	Events.connect("shortcut_clicked", on_shortcut_clicked)
	
	#var new_task = TaskData.new()
	#new_task.category = Enums.EmployeeType.GREEN
	#task_datas[0] = new_task
	#task_list.populate_task_list(task_datas)
	
	#if task_datas:
		#task_list.populate_task_list(task_datas)

func on_shortcut_clicked(key):
	if key == str(employee.id):
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
		
	overload_bar.value += 1
	
	if is_gui_clicked:
		var current_mouse_pos = get_global_mouse_position()
		
		if not prev_mouse_pos:
			prev_mouse_pos = current_mouse_pos
		
		var mouse_motion = current_mouse_pos - prev_mouse_pos
		position += mouse_motion
		prev_mouse_pos = current_mouse_pos	

func set_employee_texture():
	match employee.type:
		Enums.EmployeeType.PLAYER:
			type.texture = tex_player
		Enums.EmployeeType.GREEN:
			type.texture = tex_green
		Enums.EmployeeType.BLUE:
			type.texture = tex_blue
		Enums.EmployeeType.VIOLET:
			type.texture = tex_violet
		Enums.EmployeeType.MAGENTA:
			type.texture = tex_magenta

func _on_panel_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			var parent = get_parent()
			parent.remove_child(self)
			parent.add_child(self)
			is_gui_clicked = true
			modulate = Color(1,1,1,0.7)

func _on_texture_button_pressed():
	Events.close_clicked.emit(employee.id)
	visible = false
