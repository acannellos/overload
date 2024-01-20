extends NinePatchRect

@export var shortcut_datas: Array[ShortcutData]
@export var Shortcut_AC: PackedScene

@onready var shortcuts = $shortcuts

func _ready():
	populate_taskbar(shortcut_datas)

func populate_taskbar(shortcut_datas: Array[ShortcutData]):
	for child in shortcuts.get_children():
		child.queue_free()

	for shortcut_data in shortcut_datas:
		var sc = Shortcut_AC.instantiate()
		sc.set_employee_texture(shortcut_data)
		var k = Globals.max_id + 1
		sc.key = str(k)
		Globals.max_id += 1
		shortcuts.add_child(sc)
