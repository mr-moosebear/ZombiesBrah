extends Control

var zombie
var zombie_health : int
@onready var background = $TextureRect
@onready var front = $TextureRect2

func _ready() -> void:
	get_zombie_health()

func get_zombie_health() -> void:
	zombie = get_parent()
	zombie.connect("was_shot", _update_health_bar)
	_update_health_bar()
	foo()

func foo() -> void:
	var x_background = background.size.x

func _update_health_bar() -> void:
	zombie_health = zombie.health
	var t = zombie.shots_to_death
	var x = float(t / zombie_health)
	print(x)
	print("Zombie Health is ", zombie_health)
