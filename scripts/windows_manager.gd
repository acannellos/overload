extends Panel

@export var grabbed_task: TextureButton
var grabbed_task_data: TaskData

func _ready():
	Events.task_clicked.connect(on_task_clicked)

func on_task_clicked(index):
	grabbed_task.visible = not grabbed_task.visible

func _physics_process(delta):
	if grabbed_task.visible:
		grabbed_task.global_position = get_global_mouse_position() + Vector2(10,10)

