extends NinePatchRect

@onready var cost_label = $cost_label

func _ready():
	update_cost()

func update_cost():
	cost_label.text = "$" + str(Globals.hire_cost) + " to hire"

func _on_hire_green_pressed():
	if Globals.cash_total - Globals.cash_spent >= Globals.hire_cost:
		Globals.cash_spent += Globals.hire_cost
		Events.employee_hired.emit(Enums.EmployeeType.GREEN)

func _on_hire_blue_pressed():
	if Globals.cash_total - Globals.cash_spent >= Globals.hire_cost:
		Globals.cash_spent += Globals.hire_cost
		Events.employee_hired.emit(Enums.EmployeeType.BLUE)

func _on_hire_violet_pressed():
	if Globals.cash_total - Globals.cash_spent >= Globals.hire_cost:
		Globals.cash_spent += Globals.hire_cost
		Events.employee_hired.emit(Enums.EmployeeType.VIOLET)

func _on_hire_magenta_pressed():
	if Globals.cash_total - Globals.cash_spent >= Globals.hire_cost:
		Globals.cash_spent += Globals.hire_cost
		Events.employee_hired.emit(Enums.EmployeeType.MAGENTA)
