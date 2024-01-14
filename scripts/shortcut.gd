extends PanelContainer

#signal shortcut_clicked
#@export var texture: Texture2D
#@onready var texture_rect = $MarginContainer/TextureRect
#
#func _ready():
	#texture_rect.texture = texture

#func _process(delta):
	#pass

@export var window: NinePatchRect


func _on_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			#shortcut_clicked.emit()
			window.visible = not window.visible
			print("clicked")
