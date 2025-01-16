class_name  CompFlickerDeath
extends Node
# NOTE: Poop, Poop, Poop
@export var animated_sprite : AnimatedSprite2D

# NOTE: Needs Work and moved to a Component
func flicker_death() -> void:
	var timer : float = 1.0
	await get_tree().create_timer(1.5).timeout
	for i in range(20):
		animated_sprite.visible = !animated_sprite.visible
		await get_tree().create_timer(timer).timeout
		timer -= 0.05
		print(timer)
