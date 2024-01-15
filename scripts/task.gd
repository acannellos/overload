extends TextureButton

var is_empty: bool = true

enum SlotType{
	BASIC,
	HAZARD,
	OVERLOAD,
}

@onready var texture_rect = $TextureRect
@onready var label = $label
@onready var texture_progress_bar = $TextureProgressBar

@export var slot_type = SlotType.BASIC
@export var hazard_color: Color = Color(1,1,1)
@export var overload_color: Color = Color(1,1,1)

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("handle_ready")
	
	match slot_type:
		SlotType.HAZARD:
			modulate = hazard_color
		SlotType.OVERLOAD:
			modulate = overload_color

func handle_ready():
	if is_empty:
		texture_rect.visible = false
		label.visible = false
		texture_progress_bar.visible = false
		disabled = true
	else:
		texture_rect.visible = true
		label.visible = true
		texture_progress_bar.visible = true
		disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			Events.task_clicked.emit(get_index())
			#print("button clicked")

func set_task_data(task_data: TaskData):
	print("task data set")


func _on_pressed():
	print("button pressed")
