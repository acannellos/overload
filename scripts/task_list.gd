extends VBoxContainer

@export var task_datas: Array[TaskData]
@export var Task: PackedScene

func _ready():
	populate_task_list()
	print(get_child_count())
	size.y = 50 * get_child_count()

func _process(delta):
	pass

func populate_task_list():
	for child in get_children():
		child.queue_free()

	for task_data in task_datas:
		var task = Task.instantiate()
		add_child(task)
		if task_data:
			task.is_empty = false
			
		#task.set_task_data(task_data)
