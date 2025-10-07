class_name Enemy
extends Node3D

var player: Player
var speed = 10

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	return
	
func _physics_process(delta: float) -> void:
	var playerX: int = int(player.global_position.x)
	var playerZ: int = int(player.global_position.z)
	
	var intX = int(global_position.x)
	var intZ = int(global_position.z)
	var enemy_movement_X: float
	var enemy_movement_Z: float
	
	
	if(playerX != intX):
		enemy_movement_X = (playerX-intX)/abs(playerX-intX)
	if(playerZ != intZ):
		enemy_movement_Z = (playerZ-intZ)/abs(playerZ-intZ)
	
	var enemy_movement = Vector3(enemy_movement_X, 0., enemy_movement_Z).normalized()
	global_position += enemy_movement * speed * delta
	return
