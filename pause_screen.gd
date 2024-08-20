extends Control


@onready var map = $"."

func _on_resume_pressed():
	map.pause()


func _on_quit_pressed():
	get_tree().quit()
