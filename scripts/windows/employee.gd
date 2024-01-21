extends NinePatchRect
class_name Employee

@export var employee: EmployeeData
@export var task_datas: Array[TaskData]

@export_group("textures")
@export var tex_player: CompressedTexture2D
@export var tex_green: CompressedTexture2D
@export var tex_blue: CompressedTexture2D
@export var tex_violet: CompressedTexture2D
@export var tex_magenta: CompressedTexture2D

@onready var label = $Label
@onready var type = $type
@onready var task_list = $task_list
@onready var count_label = $count_label
@onready var overload_bar = $overload_bar
var is_overloaded: bool = false

func _ready():
	if employee:
		label.text = employee.name
	set_employee_texture()
	
	if not employee.type == Enums.EmployeeType.PLAYER:
		size.y = 300
	
	update_count_label()

func _process(delta):
	var i = 0
	for task in task_datas:
		if task:
			task.progress += 1
			if task.progress >= 999:
				Globals.task_complete += 1
				Events.task_completed.emit(Globals.task_complete)
				task_datas[i] = null
				task_list.populate_task_list(task_datas)
				update_count_label()
		i += 1
	
	var count = count_tasks()
	overload_bar.value += 1 * count
	
	if count == 0:
		overload_bar.value -= 1

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

func count_tasks() -> int:
	var count: int = 0
	for task in task_datas:
		if task:
			count += 1
	return count

func update_count_label():
	var count = count_tasks()
	count_label.text = str(count) + "/" + str(task_datas.size())
