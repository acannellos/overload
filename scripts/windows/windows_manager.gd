extends Panel

@export var grabbed_task: TextureButton
var grabbed_task_data: TaskData

func _ready():
	Events.task_clicked.connect(on_task_clicked)

func on_task_clicked(owner_window, index):
	
	match [grabbed_task_data]:
		[null]:
			grabbed_task_data = grab_task_data(owner_window, index)
		[_, MOUSE_BUTTON_LEFT]:
			drop_task_data(owner_window, grabbed_task_data, index)
	
	grabbed_task.visible = not grabbed_task.visible

func _physics_process(delta):
	if grabbed_task.visible:
		grabbed_task.global_position = get_global_mouse_position() + Vector2(10,10)

func update_grabbed_task():
	if grabbed_task_data:
		grabbed_task.show()
		grabbed_task.set_slot_data(grabbed_task_data)
	else:
		grabbed_task.hide()

func grab_task_data(owner_window, index: int) -> TaskData:
	var clicked_task_data = owner_window.task_datas[index]
	if clicked_task_data:
		owner_window.task_datas[index] = null
		owner_window.task_list.populate_task_list(owner_window.task_datas)
		return clicked_task_data
	else:
		return null

func drop_task_data(owner_window, grabbed_task_data: TaskData, index: int):
	var clicked_task_data = owner_window.task_datas[index]
	var return_task_data: TaskData
	
	if not clicked_task_data:
		owner_window.task_datas[index] = grabbed_task_data
		owner_window.task_list.populate_task_list(owner_window.task_datas)
		grabbed_task_data = null
