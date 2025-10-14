class_name EnemySpawner
extends Node3D

@export var enemy_scene: PackedScene

var player: Player
var playerDistance: int = 10

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	return

func _on_timer_timeout() -> void:
	var enemy:Enemy = enemy_scene.instantiate()
	
	var x = randf_range(0., 1.)
	var y = randf_range(0.5, 2)
	var z = randf_range(0., 1.)
	
	var spawnDirection = Vector3(x, 0, z).normalized()
	
	add_child(enemy)
	enemy.global_position = player.global_position + (spawnDirection * randf_range(10., 15.))
	enemy.global_position.y = y
	return
