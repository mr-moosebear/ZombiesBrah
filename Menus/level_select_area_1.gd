extends Control
# Default Stars
var area_stars : Dictionary = {
	"One": 0,
	"two": 2,
	"three": 0,
	"four": 0,
	"five": 0,
	"six": 0,
	"seven": 0,
	"eight": 3,
	"nine": 0,
	"ten": 0
}

func _ready() -> void:
	foo()
	
func foo() -> void:
	#var dict = Global.load_area_stars()
	var count = 0
	for i in area_stars.keys():
		#print(dict[i])
		count += int(area_stars[i])
	print(count)


func _on_level_button_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/Area_1/area_1_level_1.tscn")
