extends Node2D

@onready var crosshair = $CrosshairSprite
var shots_fired : int = 0
var can_shoot : bool = true

func _process(_delta: float) -> void:
	crosshair.position = get_local_mouse_position()
	if Input.is_action_just_pressed("click") && can_shoot:
		$GunshotSound.play()
		shoot_hole()
		shots_fired += 1
		print(shots_fired)
		can_shoot = false
		reload()

func reload() -> void:
	await get_tree().create_timer(2.0).timeout
	$ReloadSound.play()
	await get_tree().create_timer(1.0).timeout
	can_shoot = true

#NOTE: Might create a class for this so if no node it creates it for me
func shoot_hole() -> void:
	var hole_path = preload("res://Objects/Weapons/bullet.tscn")
	var hole = hole_path.instantiate()
	get_tree().current_scene.find_child("BulletHolesNode").add_child(hole)
	hole.position = get_local_mouse_position()
