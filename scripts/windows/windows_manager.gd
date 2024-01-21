extends Panel

@export var grabbed_task: TaskScene
@export var grabbed_task_data: TaskData

func _ready():
	Events.task_clicked.connect(on_task_clicked)

func on_task_clicked(owner_window, index):
	var clicked_task_data = owner_window.task_datas[index]	
	
	match [grabbed_task_data, clicked_task_data]:
		[null, null]:
			pass
		[null, clicked_task_data]:
			grab_task_data(owner_window, clicked_task_data, index)
		[_, null]:
			drop_task_data(owner_window, grabbed_task_data, index)
		[_, _]:
			pass
	
	update_grabbed_task()

func _physics_process(delta):
	if grabbed_task.visible:
		grabbed_task.global_position = get_global_mouse_position() + Vector2(10,10)

func update_grabbed_task():
	if grabbed_task_data:
		grabbed_task.show()
	else:
		grabbed_task.hide()

func grab_task_data(owner_window, clicked_task_data, index: int):
	owner_window.task_datas[index] = null
	owner_window.update_count_label()
	owner_window.task_list.populate_task_list(owner_window.task_datas)
	grabbed_task_data = clicked_task_data
	
	grabbed_task.set_employee_texture(grabbed_task_data)
	grabbed_task.is_empty = false
	grabbed_task.handle_ready()

func drop_task_data(owner_window, _grabbed_task_data: TaskData, index: int):
	owner_window.task_datas[index] = _grabbed_task_data
	owner_window.update_count_label()
	owner_window.task_list.populate_task_list(owner_window.task_datas)
	grabbed_task_data = null
	
	grabbed_task.is_empty = true
	grabbed_task.handle_ready()
