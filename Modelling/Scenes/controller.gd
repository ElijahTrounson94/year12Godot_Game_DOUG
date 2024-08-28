extends CharacterBody3D

@export var health : int = 100
@export var bullet : PackedScene
@export var speed = 5
@export var sprint = 8
@export var mouse_sensitivity = 0.003
@onready var camera = $Camera3D
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


@onready var sprite = $Camera3D/CanvasLayer/AnimatedSprite2D
@onready var crosshairImage = $"Pistol crosshair/Pistol crosshair"

@onready var ray = $Camera3D/RayCast3D
func _physics_process(delta):
	velocity.y += -gravity * delta
	var input_dir = Input.get_vector("left","right","up","down")
	var move_dir = transform.basis * Vector3(input_dir.x, 0, input_dir.y).normalized()
	if input_dir:
		velocity.x = move_dir.x * speed
		velocity.z = move_dir.z * speed
	else:
		velocity.x = 0
		velocity.z = 0
	
	move_and_slide()
	
	if ray.is_colliding():
		check_collisions()
	

	
	if Input.is_action_pressed("Sprint"):
		speed = 8
	else:
		speed = 5 
	

func check_collisions():
	var collider = ray.get_collider()
	
	
	
	
	

func _unhandled_input(event):
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x,-1,1)
	
	if(event.is_action_pressed("shoot")):
		sprite.play("shoot")
		
		var new_bullet = bullet.instantiate()
		
		get_parent().add_child(new_bullet)
		new_bullet.global_position = $Camera3D/BulletSpawn.global_position
		new_bullet.global_rotation = camera.global_rotation
		
	




func _on_hitbox_body_entered(body):
	if body.is_in_group("Enemy"):
		health -= 25
		$ProgressBar.value = health
		if health <= 0:
			get_tree().reload_current_scene()
		pass
	pass # Replace with function body.

