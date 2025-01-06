extends Node2D


func _on_bullet_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("zombie") or area.is_in_group("headshot"):
		#get_tree().current_scene.find_child(area.get_parent().name).add_child(self.duplicate())
		self.queue_free()
