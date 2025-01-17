extends StaticBody2D
# NOTE:UGLY
@export var speed : float = 25
@export var health : float = 10.0
@export var hit_power : int = 50
@export var head_shot_power : int = 4
@export var body_shot_power : int = 3
@onready var comp = $CompZombieMove

var shots_to_death : float = 10
signal attacked(hit: int)
signal was_shot

func _ready() -> void:
	$AnimatedSprite2D.play("walk")

func disconnect_colliders() -> void:
	var nodes = get_children()
	for node in nodes:
		if node != $AnimatedSprite2D:
			node.queue_free()

func die_zombie_die() -> void:
	was_shot.emit()
	if shots_to_death <= 0:
			disconnect_colliders()
			comp.undead = false
			$AnimatedSprite2D.play("death")
			await $AnimatedSprite2D.animation_finished
			#$CompFlickerDeath.flicker_death() NOT WORKING
			await get_tree().create_timer(3).timeout
			self.queue_free()

func _on_headshot_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("ammo"):
		shots_to_death -= head_shot_power
		die_zombie_die()

func _on_bodyshot_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("ammo"):
		shots_to_death -= body_shot_power
		die_zombie_die()

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("defense"):
		comp.attacking = true
		$AnimatedSprite2D.play("attack")

func _on_animated_sprite_2d_animation_looped() -> void:
	if $AnimatedSprite2D.animation == "attack":
		attacked.emit(hit_power)
