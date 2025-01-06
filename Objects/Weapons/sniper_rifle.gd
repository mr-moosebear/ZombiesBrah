extends Node2D

@onready var crosshair = $CrosshairSprite
@export var reload_delay : float = 2.0
var can_shoot : bool = true

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(_delta: float) -> void:
	crosshair.position = get_local_mouse_position()
	if Input.is_action_just_pressed("click") && can_shoot:
		$GunshotSound.play()
		shoot_hole()
		can_shoot = false
		reload()

func reload() -> void:
	await get_tree().create_timer(reload_delay).timeout
	$ReloadSound.play()
	await $ReloadSound.finished
	can_shoot = true

func shoot_hole() -> void:
	var hole_path = preload("res://Objects/Weapons/bullet.tscn")
	var hole = hole_path.instantiate()
	get_tree().current_scene.find_child("BulletHolesNode").add_child(hole)
	hole.position = get_local_mouse_position()
