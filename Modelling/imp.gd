extends CharacterBody3D

var speed = 3
var accel = 8

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player");

func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_location()
	var new_velocity = (next_location - current_location).normalised() * speed
	
	velocity = new_velocity
	move_and_slide()

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
