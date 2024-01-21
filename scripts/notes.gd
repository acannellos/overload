extends Control

@onready var done_count = $note/done_count
@onready var deleted_count = $note2/deleted_count
@onready var staff_count = $note3/staff_count

func _ready():
	Events.connect("task_completed", on_task_completed)
	Events.connect("task_deleted", on_task_deleted)
	Events.connect("employee_hired", on_employee_hired)

func on_task_completed():
	done_count.text = str(Globals.task_complete)

func on_task_deleted(owner_window, index):
	deleted_count.text = str(Globals.task_delete)

func on_employee_hired(type):
	staff_count.text = str(Globals.max_id - 1)
