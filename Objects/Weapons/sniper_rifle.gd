extends Node2D

@onready var crosshair = $CrosshairSprite
@export var reload_delay : float = 1.5
var can_shoot : bool = true

signal update_sniper_ui
signal reload_finished


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(_delta: float) -> void:
	crosshair.position = get_local_mouse_position()
	if Input.is_action_just_pressed("click") && can_shoot:
		$GunshotSound.play()
		update_sniper_ui.emit()
		shoot_hole()
		can_shoot = false
		reload()

func reload() -> void:
	await get_tree().create_timer(reload_delay).timeout
	$ReloadSound.play()
	await $ReloadSound.finished
	reload_finished.emit()
	can_shoot = true

#TODO: Create layer for Bullet holes
func shoot_hole() -> void:
	var hole_path = preload("res://Objects/Weapons/bullet.tscn")
	var hole = hole_path.instantiate()
	get_tree().current_scene.find_child("BulletHolesNode").add_child(hole)
	hole.position = get_local_mouse_position()
