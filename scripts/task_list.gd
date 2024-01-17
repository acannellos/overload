extends VBoxContainer

#@export var task_datas: Array[TaskData]
@export var Task: PackedScene
var player

func _ready():
	#var player = get_parent()
	#populate_task_list(player.task_datas)
	#print(get_child_count())
	#size.y = 50 * get_child_count()
	
	call_deferred("handle_ready")

func handle_ready():
	var player = get_parent()
	
	if player.task_datas:
		populate_task_list(player.task_datas)
	#print(get_child_count())
	size.y = 50 * get_child_count()

func _process(delta):
	pass

func populate_task_list(task_datas: Array[TaskData]):
	for child in get_children():
		child.queue_free()

	for task_data in task_datas:
		var task = Task.instantiate()
		add_child(task)
		if task_data:
			task.is_empty = false
			
		#task.set_task_data(task_data)
