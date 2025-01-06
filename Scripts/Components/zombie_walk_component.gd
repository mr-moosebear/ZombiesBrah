class_name CompZombieWalk
extends Node

@export var zombie : StaticBody2D
@export var speed : float = -25
var undead : bool = true

func _physics_process(delta: float) -> void:
	if undead:
		zombie.position.x += speed * delta
		zombie.move_and_collide(Vector2(0, 1))
