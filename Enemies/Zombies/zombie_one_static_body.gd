extends StaticBody2D

@onready var zombie_sprite = $AnimatedSprite2D
@export var speed : float = 25
@export var shots_to_death : int = 5
@export var hit_power : int = 50
var undead : bool = true
var attacking : bool = false
var moving_left : bool = true

signal attacked(int)

func _ready() -> void:
	zombie_sprite.play("walk")
	set_walking_direction()

func _physics_process(delta: float) -> void:
	if undead && !attacking:
		if moving_left:
			position.x -= speed * delta
		else:
			position.x += speed * delta
		move_and_collide(Vector2(0, 1))

func die_zombie_die() -> void:
	zombie_sprite.play("death")
	await zombie_sprite.animation_finished
	await get_tree().create_timer(3).timeout
	self.queue_free()

func set_walking_direction() -> void:
	var screen = get_tree().root.get_viewport().size
	var middle_point = screen.x / 2
	if position.x < middle_point:
		$AnimatedSprite2D.flip_h = true
		moving_left = false

func _on_headshot_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("ammo"):
		shots_to_death -= 3
		print("Shot hit Head, shots left are ", shots_to_death)
		if shots_to_death <= 0:
			undead = false
			die_zombie_die()

func _on_bodyshot_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("ammo"):
		shots_to_death -= 1
		print("Shot hit body, shots left are ", shots_to_death)
		if shots_to_death <= 0:
			undead = false
			die_zombie_die()

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("defenses"):
		attacking = true
		zombie_sprite.play("attack")

func _on_animated_sprite_2d_animation_looped() -> void:
	if zombie_sprite.animation == "attack":
		attacked.emit(hit_power)
