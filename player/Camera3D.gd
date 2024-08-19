extends Camera3D
var scoped = false
var canshoot = true
var current_rot
var rayrange = 1000
@onready var ani = $"../../../CanvasLayer/gun/ani"
@onready var ap = $AnimationPlayer

@onready var player = $"../../.."

#soundefects
@onready var gunshot = $"../../../soundefects/gunshot"
@onready var loadshot = $"../../../soundefects/loadshot"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	if Input.is_action_just_pressed("rightclick"):
		ani.play("scope in")

	if Input.is_action_just_released("rightclick"):
		ani.play("scope out")
		
		$"../../../CanvasLayer/gun".visible = true
		$"../../../CanvasLayer/scope".visible = false
		fov = 75
		scoped = false
	
	if player.velocity != Vector3.ZERO and player.is_on_floor and ap.is_playing() == false:
		ap.play("walk")
		
	
	#if player.velocity == Vector3.ZERO and player.is_on_floor:
	#	ap.play("idle")

func _input(event):
	if event.is_action_pressed("shoot") and canshoot == true:
		Get_Camera_Collision()
		gunshot.play()
		canshoot = false
		ap.play("recoil")




func Get_Camera_Collision():
	var center = get_viewport().size / 2
	
	var ray_orgin = project_ray_origin(center)
	var ray_end = ray_orgin + project_ray_normal(center) * rayrange
	
	var new_intersection = PhysicsRayQueryParameters3D.create(ray_orgin, ray_end)
	var intersection = get_world_3d().direct_space_state.intersect_ray(new_intersection)
	
	if not intersection.is_empty():
		print(intersection.collider.name)
	else:
		print("nothing")

func _physics_process(delta):
	pass



func _on_ani_animation_finished():
	if Input.is_action_pressed("rightclick"):
		ani.stop()
		$"../../../CanvasLayer/gun".visible = false
		$"../../../CanvasLayer/scope".visible = true
		scoped = true
		fov = 20
	else:
		pass




func _on_animation_player_animation_finished(anim_name):
	print(anim_name)
	if anim_name == "recoil":
		loadshot.play()
		


func _on_loadshot_finished():
	canshoot = true
