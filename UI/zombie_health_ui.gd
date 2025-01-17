extends Control

var zombie
var zombie_health : float
@onready var front = $TextureRect2

func _ready() -> void:
	get_zombie_health()


func get_zombie_health() -> void:
	zombie = get_parent()
	zombie_health = zombie.health
	zombie.connect("was_shot", _update_health_bar)
	_update_health_bar()


func _update_health_bar() -> void:
	var x = zombie.shots_to_death / zombie_health
	var t = front.size.x
	front.size.x = t * x
	if (t * x) <= 0:
		queue_free()
