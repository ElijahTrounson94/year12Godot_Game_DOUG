extends CharacterBody3D

var speed = 2
var accel = 8

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player");

func _physics_process(delta):
	update_target_location(player.global_position)
	
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * speed
	
	velocity = new_velocity
	move_and_slide()

func update_target_location(target_location):
	nav_agent.target_position = target_location
	
@export var health: int = 100
@export var death_animation: AnimatedSprite3D = null

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		die()

func die():
	# Play death animation if it exists
	if death_animation:
		death_animation.play("Death")

	# Queue the enemy for deletion after the animation finishes
	# If there's no animation, delete it immediately
	if death_animation:
		await death_animation.animation_finished
	queue_free()

#
	#nav_agent.target_position = player.global_transform.origin
	#
	#var direction = nav_agent.get_next_path_position()
	#
	#"""
	#if not is_on_floor():
		#direction.y -= 9.8*delta;
	#else:
		#direction.y -= 2;
	#"""
	#
#
	#
	#
	#velocity = velocity.move_toward(direction * speed , accel * delta);
	#
	#move_and_slide();
