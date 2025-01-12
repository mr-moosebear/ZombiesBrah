extends StaticBody2D
# NOTE:UGLY
@export var speed : float = 25
@export var shots_to_death : int = 5
@export var hit_power : int = 50

@onready var comp = $CompZombieMove
signal attacked(hit: int)

func _ready() -> void:
	$AnimatedSprite2D.play("walk")

func disconnect_colliders() -> void:
	var nodes = get_children()
	for node in nodes:
		if node != $AnimatedSprite2D:
			node.queue_free()

func die_zombie_die() -> void:
	if shots_to_death <= 0:
			disconnect_colliders()
			comp.undead = false
			$AnimatedSprite2D.play("death")
			flicker_death()
			await $AnimatedSprite2D.animation_finished
			await get_tree().create_timer(3).timeout
			self.queue_free()

# NOTE: Needs Work
func flicker_death() -> void:
	var timer : float = 1.0
	await get_tree().create_timer(1.5).timeout
	for i in range(20):
		$AnimatedSprite2D.visible = !$AnimatedSprite2D.visible
		await get_tree().create_timer(timer).timeout
		timer -= 0.05
		print(timer)

func _on_headshot_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("ammo"):
		shots_to_death -= 3
		die_zombie_die()

func _on_bodyshot_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("ammo"):
		shots_to_death -= 1
		die_zombie_die()

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("defense"):
		comp.attacking = true
		$AnimatedSprite2D.play("attack")

func _on_animated_sprite_2d_animation_looped() -> void:
	if $AnimatedSprite2D.animation == "attack":
		attacked.emit(hit_power)
