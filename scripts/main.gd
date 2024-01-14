extends Node2D

var hand = load("res://assets/textures/cursor.hand.small.png")
var handclick = load("res://assets/textures/cursor.handclick.small.wip.png")

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

func _process(delta):
	pass
