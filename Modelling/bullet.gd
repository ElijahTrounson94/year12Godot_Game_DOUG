extends CharacterBody3D
@export var bullspeed: float = 100
@export var damage: int = 50

func _process(delta: float) -> void:
	velocity = -transform.basis.z * bullspeed
	move_and_slide()
	
	# Check for collisions
	if is_on_wall():
		queue_free()  # Destroy the projectile if it hits a wall

func _on_body_entered(body: Node) -> void:
	print(body)
	if body.is_in_group("Enemy"):  # Assuming enemies are in an "enemies" group
		body.take_damage(damage)
		queue_free()  # Destroy the projectile after hitting an enemy
		
