extends CanvasLayer


@export var main_scene: PackedScene


func _on_timer_timeout():
	get_tree().change_scene_to_packed(main_scene)

