extends StaticBody2D


@onready var zombie_sprite = $AnimatedSprite2D
@export var speed : float = -25
var shots_to_death = 5
var sprite : Sprite2D
var wound_pos
var undead : bool = true
var attacking : bool = false

func _ready() -> void:
	zombie_sprite.play("walk")

func _physics_process(delta: float) -> void:
	if undead && !attacking:
		position.x += speed * delta
		move_and_collide(Vector2(0, 1))
		
func _on_headshot_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("ammo"):
		shots_to_death -= 3
		print("Shot hit Head, shots left are ", shots_to_death)
		if shots_to_death <= 0:
			undead = false
			zombie_sprite.play("death")
			await zombie_sprite.animation_finished
			await get_tree().create_timer(3).timeout
			self.queue_free()


func _on_bodyshot_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("ammo"):
		shots_to_death -= 1
		print("Shot hit body, shots left are ", shots_to_death)
		if shots_to_death <= 0:
			undead = false
			zombie_sprite.play("death")
			await zombie_sprite.animation_finished
			await get_tree().create_timer(3).timeout
			self.queue_free()
