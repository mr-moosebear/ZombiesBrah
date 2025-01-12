extends Control
#NOTE: probably make this a component and just pass 
# the values through script for mag size and amount
@export var mag_size : int = 1
@export var bullets_in_mag : int
@export var amount_of_ammo : int = 50
var reloaded : bool = true

func _ready() -> void:
	bullets_in_mag = mag_size
	$BulletsLeftLabel.text = str(bullets_in_mag)
	var gun = get_parent()
	gun.connect("update_sniper_ui", _update_bullets_left)
	gun.connect("reload_finished", _reload_gun)

func _reload_gun() -> void:
	bullets_in_mag = mag_size
	amount_of_ammo -= mag_size
	$BulletsLeftLabel.text = str(bullets_in_mag)
	$AmmoAmountLabel.text = str(amount_of_ammo)

func _update_bullets_left() -> void:
	bullets_in_mag -= 1
	$BulletsLeftLabel.text = str(bullets_in_mag)
