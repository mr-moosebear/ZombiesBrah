extends StaticBody2D


@onready var zombie_sprite = $AnimatedSprite2D
var shots_to_death = 5
var sprite : Sprite2D
var wound_pos

func _ready() -> void:
	zombie_sprite.play("walk")

func _on_headshot_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("ammo"):
		shots_to_death -= 5
		print("Shot hit Head, shots left are ", shots_to_death)
		if shots_to_death <= 0:
			$CompZombieWalk.undead = false
			zombie_sprite.play("death")
			await zombie_sprite.animation_finished
			await get_tree().create_timer(3).timeout
			self.queue_free()
