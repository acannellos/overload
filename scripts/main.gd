extends CanvasLayer

var hand = load("res://assets/textures/cursor.hand.small.png")
var handclick = load("res://assets/textures/cursor.handclick.small.png")
var handclick_56 = load("res://assets/textures/cursor.handclick.small.56.png")

@onready var taskbar = $screen/taskbar

var currentHour : int = 8
var currentMinute : int = 0
var ampm : String = "AM"

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

func update_clock():
	if currentMinute >= 60:
		currentMinute = 0
		currentHour += 1

	if currentHour == 13:
		currentHour = 1
		toggle_ampm()

	var formattedHour : String = str(currentHour).pad_zeros(1)
	var formattedMinute : String = str(currentMinute).pad_zeros(2)

	taskbar.clock_label.text = formattedHour + ":" + formattedMinute + " " + ampm

func toggle_ampm():
	if ampm == "AM":
		ampm = "PM"
	else:
		ampm = "AM"

func _on_timer_timeout():
	currentMinute += 10
	update_clock()
