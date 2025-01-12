extends StaticBody2D

@export var health : int = 1000
var group_nodes : Array
var scene

func _ready() -> void:
	connect_zombie_signals()

func update_health(hit: int) -> void:
	health -= hit
	if health <= 0:
		print("Tower Gone")
		queue_free()

func connect_zombie_signals() -> void:
	group_nodes = get_tree().get_nodes_in_group("zombie")
	for i in group_nodes.size():
		scene = group_nodes[i]
		print("Connecting signal to ", group_nodes[i])
		scene.connect("attacked", _on_enemy_attacked)

func _on_enemy_attacked(hit_power: int) -> void:
	update_health(hit_power)
