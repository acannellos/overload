extends Resource
class_name TaskData

enum TaskCategory{
	DEFAULT,
	GREEN,
	BLUE,
	VIOLET,
	MAGENTA,
}

@export var name: String = "task"
@export var category = TaskCategory.DEFAULT
@export var progress: float = 0.0
@export var goal: float = 100.0
