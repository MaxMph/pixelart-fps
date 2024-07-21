extends CharacterBody3D


const JUMP_VELOCITY = 5.5
var SENSITIVITY = 0.003
var basesense = 0.003
var SPEED
const basespeed = 6
var extraspeed = 0
var extravel = Vector3.ZERO

var FRIC = 30
var ACC = 20

var BASE_FRIC = 30
var BASE_ACC = 30

var airACC = 30
var airFRIC = 1


@onready var head = $head
@onready var camera = $head/Camera3D

@onready var anim_player = $head/AnimationPlayer




var gravity = 14 


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))

func _process(delta):
	if get_node("head/Camera3D").scoped == true:
		SENSITIVITY = basesense / 4
	else:
		SENSITIVITY = basesense

func _physics_process(delta):
	SPEED = basespeed + extraspeed
	
	
	# Add the gravity.
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	#if not sliding:
		ACC = airACC
		FRIC = airFRIC
	else:
		ACC = BASE_ACC
		FRIC = BASE_FRIC

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	

	
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * SPEED, ACC * delta)
		velocity.z = move_toward(velocity.z, direction.z * SPEED, ACC * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRIC * delta)
		velocity.z = move_toward(velocity.z, 0, FRIC * delta)
	
	
	if SPEED > basespeed and is_on_floor():
		extraspeed = move_toward(extraspeed, 0, 0.05)
	
	if Input.is_action_pressed("shift"):
		velocity

	move_and_slide()
