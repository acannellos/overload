extends TextureButton

@export var key: String = "default"

@export_group("textures")
@export var tex_green: CompressedTexture2D
@export var tex_blue: CompressedTexture2D
@export var tex_violet: CompressedTexture2D
@export var tex_magenta: CompressedTexture2D

@export_group("textures_50")
@export var tex_green_50: CompressedTexture2D
@export var tex_blue_50: CompressedTexture2D
@export var tex_violet_50: CompressedTexture2D
@export var tex_magenta_50: CompressedTexture2D

@onready var blip = $blip

func _ready():
	Events.connect("close_clicked", on_close_clicked)

func on_close_clicked(close_key):
	if str(close_key) == key:
		blip.visible = not blip.visible

func set_employee_texture(shortcut_data: ShortcutData):
	match shortcut_data.shortcut_type:
		Enums.EmployeeType.GREEN:
			texture_hover = tex_green
			texture_normal = tex_green_50
		Enums.EmployeeType.BLUE:
			texture_hover = tex_blue
			texture_normal = tex_blue_50
		Enums.EmployeeType.VIOLET:
			texture_hover = tex_violet
			texture_normal = tex_violet_50
		Enums.EmployeeType.MAGENTA:
			texture_hover = tex_magenta
			texture_normal = tex_magenta_50

func _on_pressed():
	Events.shortcut_clicked.emit(key)
	blip.visible = not blip.visible
