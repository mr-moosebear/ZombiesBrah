extends StaticBody2D

@onready var collision = $CollisionShape2D

func _ready() -> void:
	$AnimatedSprite2D.play("walk")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += -25 * delta
	move_and_collide(Vector2(0, 1))


func _on_headshot_area_body_entered(body: Node2D) -> void:
	print(body)
