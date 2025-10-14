class_name Player
extends Node3D

var isReloading: bool = false
var healthbar
var killCount: int = 0

@export var move_speed:float = 10
@export var health: int = 3
@export var attackVfx: PackedScene

@onready var animation_tree: AnimationTree = $RigidBody3D/characterMedium/AnimationTree

var move_inputs: Vector3

func _ready() -> void:
	healthbar = $RigidBody3D/SubViewport/HealthBar
	healthbar.max_value = health

func _process(_delta:float) -> void:
	if Input.is_action_just_pressed("damage_player"):
		health -= 1
		healthbar.update(health)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		attack()
	read_move_inputs()
	move_inputs *= move_speed * delta
	animation_tree.set("parameters/conditions/isIdling", move_inputs == Vector3.ZERO)
	animation_tree.set("parameters/conditions/isRunning", move_inputs != Vector3.ZERO)
	if move_inputs != Vector3.ZERO:
		var playerGaze = global_position - move_inputs
		look_at(playerGaze)
		global_position += move_inputs
	return

func read_move_inputs():
	move_inputs.x = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
	move_inputs.z = Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward")
	move_inputs = move_inputs.normalized()
	return

func take_damage(dmg_amount):
	health -= dmg_amount
	healthbar.update(health)
	if (health <= 0 and !isReloading):
		isReloading = !isReloading
		GameManager.gameOver()
	return
	
func attack():
	var camera = get_tree().get_first_node_in_group("camera")

	var screen_pos = get_viewport().get_mouse_position()

	var from = camera.project_ray_origin(screen_pos)
	var to = from + camera.project_ray_normal(screen_pos) * 1000.0

	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)

	var result = space_state.intersect_ray(query)
	
	if result:
		var attack = attackVfx.instantiate()
		add_child(attack)
		attack.global_position = result.position
		attack.emit()
	
	return
