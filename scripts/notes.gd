extends Control

@onready var done_count = $note/done_count

func _ready():
	Events.connect("task_completed", on_task_completed)

func on_task_completed(value):
	done_count.text = str(value)
