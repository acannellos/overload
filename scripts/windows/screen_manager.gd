extends NinePatchRect

@export var EmployeeScene: PackedScene
@export var ShortcutScene: PackedScene

@onready var windows = $windows
@onready var taskbar = $taskbar

var spawn: Vector2 = Vector2(5.0,5.0)
var seperator: Vector2 = Vector2(20,20)
var i = 1

func _ready():
	Events.connect("employee_hired", on_employee_hired)

func on_employee_hired(type):
	var employee_window = EmployeeScene.instantiate()
	employee_window.position = spawn
	spawn += seperator
	
	employee_window.task_datas.resize(2)
	
	employee_window.employee.name = get_random_employee_name()
	employee_window.employee.type = type
	employee_window.employee.id = Globals.max_id
	print(Globals.max_id)
	print(employee_window.employee.id)
	Globals.max_id += 1
	windows.add_child(employee_window)
	
	if spawn.y > 400:
		spawn = Vector2(5.0,5.0) + Vector2(20,0) * i
		i += 1
	
	var new_shortcut_data = ShortcutData.new()
	new_shortcut_data.shortcut_type = type
	taskbar.shortcut_datas.append(new_shortcut_data)
	taskbar.populate_taskbar(taskbar.shortcut_datas)

func get_random_employee_name() -> String: 
	var employee_names = ["Abe", "Boon", "Clem", "Dex", "Shmo", "Momo", "Tata"]
	return employee_names[randi() % employee_names.size()]
