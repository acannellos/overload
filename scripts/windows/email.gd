extends NinePatchRect

@export var task_datas: Array[TaskData]

@onready var task_list = $task_list
@onready var count_label = $count_label

func _ready():
	update_count_label()

func _on_timer_timeout():
	var count = 0
	for task in task_datas:
		if not task:
			var new_task_data = TaskData.new()
			new_task_data.category = get_random_employee_type()
			task_datas[count] = new_task_data
			task_list.populate_task_list(task_datas)
			update_count_label()
			return
		count += 1

func get_random_employee_type() -> Enums.EmployeeType:
	var employee_types = [Enums.EmployeeType.GREEN, Enums.EmployeeType.BLUE, Enums.EmployeeType.VIOLET, Enums.EmployeeType.MAGENTA]
	return employee_types[randi() % employee_types.size()]

func count_tasks() -> int:
	var count: int = 0
	for task in task_datas:
		if task:
			count += 1
	return count

func update_count_label():
	var count = count_tasks()
	count_label.text = str(count) + "/" + str(task_datas.size())
