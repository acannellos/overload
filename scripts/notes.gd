extends Control

@onready var done_count = $note/done_count
@onready var deleted_count = $note2/deleted_count


func _ready():
	Events.connect("task_completed", on_task_completed)
	Events.connect("task_deleted", on_task_deleted)

func on_task_completed(value):
	done_count.text = str(value)

func on_task_deleted(owner_window, index):
	deleted_count.text = str(Globals.task_delete)
