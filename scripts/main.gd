extends CanvasLayer

var hand = load("res://assets/textures/cursor.hand.small.png")
var handclick = load("res://assets/textures/cursor.handclick.small.wip.png")
var handclick_56 = load("res://assets/textures/cursor.handclick.small.wip.56.png")

@export var handclick_sprite: Sprite2D

var can_move_mouse: bool = true
var is_mouse_pressed: bool = false
var needs_change: bool = false
var last_pos: Vector2 = Vector2.ZERO

func _ready():
	Input.set_custom_mouse_cursor(hand)
	#if handclick_sprite:
		#handclick_sprite.visible = false

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			Input.set_custom_mouse_cursor(handclick)
			#is_mouse_pressed = true
			#needs_change = true
			
			#Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
			#if not can_move_mouse:
				#handclick_sprite.visible = true
				#handclick_sprite.position = get_viewport().get_mouse_position()

	if event is InputEventMouseButton and event.is_released():
		if event.button_index == MOUSE_BUTTON_LEFT:
			Input.set_custom_mouse_cursor(hand)
			#is_mouse_pressed = false
			#handclick_sprite.visible = false
			#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _unhandled_input(event: InputEvent):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _process(delta):
	pass
	#_can_move_mouse()
	#if not can_move_mouse and is_mouse_pressed:
		#if needs_change:
			#Events.mouse_stopped.emit()
			##Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
			#Input.set_custom_mouse_cursor(handclick_56)
			#handclick_sprite.visible = true
			#handclick_sprite.position = get_viewport().get_mouse_position()
			#needs_change = false
		#Input.warp_mouse(last_pos)
	#else:
		#last_pos = get_viewport().get_mouse_position()

#func _can_move_mouse():
	#var mouse_pos = get_viewport().get_mouse_position()
	#if (mouse_pos.x > 106 and mouse_pos.x < 838) and (mouse_pos.y > 80 and mouse_pos.y < 446):
		##if mouse_pos.y > 80 and mouse_pos.y < 446:
			#can_move_mouse = true
			##print(mouse_pos)
	#else:
		#can_move_mouse = false
		##print(mouse_pos)
