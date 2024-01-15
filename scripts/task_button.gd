extends TextureButton

var is_empty: bool = true

@onready var texture_rect = $TextureRect
@onready var label = $label
@onready var texture_progress_bar = $TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("handle_ready")

func handle_ready():
	if is_empty:
		texture_rect.visible = false
		label.visible = false
		texture_progress_bar.visible = false
		disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			Events.task_clicked.emit(get_index())
			print("button clicked")

func set_task_data():
	print("task data set")
