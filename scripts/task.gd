extends TextureButton

var is_empty: bool = true

@onready var texture_rect = $TextureRect
@onready var label = $label
@onready var texture_progress_bar = $TextureProgressBar

func _ready():
	call_deferred("handle_ready")

func handle_ready():
	if is_empty:
		texture_rect.visible = false
		label.visible = false
		texture_progress_bar.visible = false
		disabled = true
		#mouse_filter = Control.MOUSE_FILTER_IGNORE
		#mouse_force_pass_scroll_events = false
	else:
		texture_rect.visible = true
		label.visible = true
		texture_progress_bar.visible = true
		disabled = false
		#mouse_filter = Control.MOUSE_FILTER_STOP
		#mouse_force_pass_scroll_events = true

func _process(delta):
	pass

func _on_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			Events.task_clicked.emit(get_index())
			print(get_index())
			#print("button clicked")

func set_task_data(task_data: TaskData):
	print("task data set")


func _on_pressed():
	print("button pressed")
