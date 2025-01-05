extends Node



#NOTE; Dictionary will not be saved in order
func save_area_stars(dict: Dictionary) -> void:
	var file = FileAccess.open("res://PlayerData/area_one.json", FileAccess.WRITE)
	#var file = FileAccess.open("user:PlayerBoard.json", FileAccess.WRITE)
	var json = JSON.stringify(dict)
	file.store_line(json)
	file.close()

func load_area_stars():
	var file = FileAccess.open("res://PlayerData/area_one.json", FileAccess.READ)
	#var file = FileAccess.open("res://PlayerBoard.json", FileAccess.READ)
	var string = file.get_as_text()
	var json = JSON.new()
	var err = json.parse(string)
	if err == OK:
		var data_retrieved = json.data
		if typeof(data_retrieved) == TYPE_DICTIONARY:
			return data_retrieved
		else:
			return
	else:
		return
