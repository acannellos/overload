extends CanvasLayer

var hand = load("res://assets/textures/cursor.hand.small.png")
var handclick = load("res://assets/textures/cursor.handclick.small.png")
var handclick_56 = load("res://assets/textures/cursor.handclick.small.56.png")

func _ready():
	Input.set_custom_mouse_cursor(hand)

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			Input.set_custom_mouse_cursor(handclick)

	if event is InputEventMouseButton and event.is_released():
		if event.button_index == MOUSE_BUTTON_LEFT:
			Input.set_custom_mouse_cursor(hand)

func _unhandled_input(event: InputEvent):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
