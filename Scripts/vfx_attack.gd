extends Area3D 

@onready var flash = $Flash
@onready var sparks = $Sparks
@onready var shockwave = $Shockwave
@onready var flare = $Flare

var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func emit():
	flash.emitting = true
	flare.emitting = true
	shockwave.emitting = true
	sparks.emitting = true

func _on_shockwave_finished() -> void:
	queue_free()


func _on_body_entered(body: Node3D) -> void:
	if (body is Enemy):
		body.queue_free()
		player.killCount += 1
		GameManager.updateScore(player.killCount)
	return
