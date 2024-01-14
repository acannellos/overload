extends Resource
class_name PlayerData

@export var value: float = 0.0
@export var max_value: float = 100.0

func update_value(amount):
	value += amount
	value = clamp(value, 0, max_value)
