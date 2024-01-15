extends Resource
class_name IDCardData

@export var name: String
@export var days_employed: int

@export var workload: float = 0.0:
	set = set_workload
@export var max_workload: float = 100.0

func set_workload(amount):
	workload += amount
	workload = clamp(workload, 0, max_workload)
