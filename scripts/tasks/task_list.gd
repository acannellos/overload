extends VBoxContainer

@export var Task: PackedScene

func _ready():
	call_deferred("handle_ready")
	

#func _process(delta):
	#for task in get_children():
		#if not task.is_empty:
			#task.update_progress()

func handle_ready():
	var owner_window = get_parent()
	if owner_window.task_datas:
		populate_task_list(owner_window.task_datas)
	size.y = 50 * get_child_count()

func populate_task_list(task_datas: Array[TaskData]):
	for child in get_children():
		child.queue_free()

	for task_data in task_datas:
		var task = Task.instantiate()
		add_child(task)
		if task_data:
			task.is_empty = false
			task.set_employee_texture(task_data)
