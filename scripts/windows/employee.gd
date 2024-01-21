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
@onready var overload_label = $overload_bar/overload_label
@onready var x = $x


var is_overloaded: bool = false
var overload_color : Color = Color(0.8627, 0.1961, 0.1843, 1.0)
var start_color : Color = Color(1.0, 1.0, 1.0, 1.0)

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
		if task and not is_overloaded:
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
		overload_bar.value -= 3
	
	var progress_percentage = overload_bar.value / overload_bar.max_value
	#overload_bar.modulate = Color(1.0, 1.0 - progress_percentage, 1.0 - progress_percentage, 1.0)
	var interpolated_color = Color(
		start_color.r + (overload_color.r - start_color.r) * progress_percentage,
		start_color.g + (overload_color.g - start_color.g) * progress_percentage,
		start_color.b + (overload_color.b - start_color.b) * progress_percentage,
		start_color.a + (overload_color.a - start_color.a) * progress_percentage
	)
	
	overload_bar.modulate = interpolated_color

	if overload_bar.value >= overload_bar.max_value:
		is_overloaded = true
		overload_label.text = "overloaded"
		x.show()
	else:
		is_overloaded = false
		overload_label.text = "workload"
		x.hide()

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
