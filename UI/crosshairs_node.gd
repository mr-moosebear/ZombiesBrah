extends Node2D

@onready var crosshair = $Crosshairs
var shots_fired : int = 0
var can_shoot : bool = true

func _process(delta: float) -> void:
	crosshair.position = get_local_mouse_position()
	if Input.is_action_just_pressed("click") && can_shoot:
		$SniperShotSound.play()
		shoot_hole()
		shots_fired += 1
		print(shots_fired)
		can_shoot = false

func reload() -> void:
	pass
	

func shoot_hole() -> void:
	var t = Sprite2D.new()
	add_child(t)
	t.texture = load("res://Art/Objects/gunshot_animation.png")
	t.position = get_local_mouse_position()


func _on_reload_delay_timeout() -> void:
	$ReloadSound.play()
	can_shoot = true
