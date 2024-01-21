extends NinePatchRect

@onready var cost_label = $cost_label

func _ready():
	update_cost()

func update_cost():
	cost_label.text = "$" + str(Globals.hire_cost) + " to hire"


func _on_hire_green_pressed():
	pass # Replace with function body.


func _on_hire_blue_pressed():
	pass # Replace with function body.


func _on_hire_violet_pressed():
	pass # Replace with function body.


func _on_hire_magenta_pressed():
	pass # Replace with function body.
