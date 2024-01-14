extends Node2D

var hand = load("res://assets/textures/cursor.hand.small.png")

func _ready():
	Input.set_custom_mouse_cursor(hand)

func _unhandled_input(event: InputEvent):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _process(delta):
	pass
