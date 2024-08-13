extends CharacterBody3D

var speed = 3
var accel = 8

@onready var nav: NavigationAgent3D = $NavigationAgent3D
@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player");

func _physics_process(delta):
	nav.target_position = player.global_position;
	
	var direction = (player.global_position - nav.get_next_path_position()).normalized();
	
	if not is_on_floor():
		direction.y -= 9.8*delta;
	else:
		direction.y -= 2;
	
	velocity = velocity.move_toward(direction * speed , accel * delta);
	
	move_and_slide();
