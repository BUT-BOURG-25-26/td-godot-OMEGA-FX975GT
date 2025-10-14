class_name Enemy
extends CharacterBody3D

var player: Player
var speed = 5

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	return
	
func _physics_process(delta: float) -> void:
	var lookAtPlayer: Vector3 = player.global_position
	lookAtPlayer.y = global_position.y
	look_at(lookAtPlayer)
	
	move_towards_player(delta)
	
	hit_player(1)
	
	return

func hit_player(damage: int) -> void:
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if(collision.get_collider().is_in_group("player")):
			queue_free()
			player.take_damage(damage)
	return

func move_towards_player(delta: float) -> void:
	var playerPosition: Vector3 = player.global_position
	var direction: Vector3 = (playerPosition - global_position).normalized()
	velocity = direction * speed * delta
	global_position += velocity
	return
	
#func old_movement(delta: float) -> void:
	#var playerX: int = int(player.global_position.x)
	#var playerZ: int = int(player.global_position.z)
	#var intX = int(global_position.x)
	#var intZ = int(global_position.z)
	#var enemy_movement_X: float
	#var enemy_movement_Z: float
	#if(playerX != intX):
		#enemy_movement_X = (playerX-intX)/abs(playerX-intX)
	#if(playerZ != intZ):
		#enemy_movement_Z = (playerZ-intZ)/abs(playerZ-intZ)
	#var enemy_movement = Vector3(enemy_movement_X, 0., enemy_movement_Z).normalized()
	#global_position += enemy_movement * speed * delta
	#return
	
