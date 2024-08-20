extends Node3D

@onready var pausescreen = $"pause screen"
var paused = false

func _process(delta):
	if Input.is_action_just_pressed("esc"):
		pause()

func pause():
	if paused:
		pausescreen.hide()
		Engine.time_scale = 1
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		pausescreen.show()
		Engine.time_scale = 0
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	paused = !paused
