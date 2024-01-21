extends NinePatchRect

@onready var total = $list/total
@onready var spent = $list/spent
@onready var left = $list/left

func _ready():
	_update_list()
	handle_ready()

func handle_ready():
	Events.close_clicked.emit("budget")

func _update_list():
	total.text = "Total: $" + str(Globals.cash_total)
	spent.text = "Spent: $" + str(Globals.cash_spent)
	left.text = "Left: $" + str(Globals.cash_total - Globals.cash_spent)
