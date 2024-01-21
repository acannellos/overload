extends TextureButton
class_name TaskScene

@export var is_empty: bool = true

@export_group("textures")
@export var tex_green: CompressedTexture2D
@export var tex_blue: CompressedTexture2D
@export var tex_violet: CompressedTexture2D
@export var tex_magenta: CompressedTexture2D

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
	else:
		texture_rect.visible = true
		label.visible = true
		texture_progress_bar.visible = true
		disabled = false

func _process(delta):
	var parent = get_parent()
	var gparent = parent.get_parent()
	
	#var val = 1
	#if not is_empty and gparent is Employee and not gparent.is_overloaded:
		#texture_progress_bar.value += 1
		#Events.task_progressed.emit()

func _on_gui_input(event):
	#SUPER HACK
	var parent = get_parent()
	var gparent = parent.get_parent()
	
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			Events.task_clicked.emit(gparent, get_index())
		
		if event.button_index == MOUSE_BUTTON_RIGHT and gparent is Employee:
			Globals.task_delete += 1
			Events.task_deleted.emit(gparent, get_index())

func set_employee_texture(task_data: TaskData):
	
	texture_progress_bar.value = task_data.progress
	
	match task_data.category:
		Enums.EmployeeType.GREEN:
			texture_rect.texture = tex_green
		Enums.EmployeeType.BLUE:
			texture_rect.texture = tex_blue
		Enums.EmployeeType.VIOLET:
			texture_rect.texture = tex_violet
		Enums.EmployeeType.MAGENTA:
			texture_rect.texture = tex_magenta

func update_progress(v):
	texture_progress_bar.value = v
