extends Resource
class_name SlotData

enum SlotType{
	BASIC,
	HAZARD,
	OVERLOAD,
}

@export var task_data: TaskData
@export var slot_type = SlotType.BASIC
#@export var progress: float = 0.0
#@export var goal: float = 100.0
