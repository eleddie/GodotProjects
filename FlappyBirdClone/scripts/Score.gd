extends Node

var current_score = 0
var highest_score = 0

const SCORE_SAVE_PATH = "user://savegame.save"

func increase_highest_score():
	highest_score += 1

func save_highest_score():
	var file = FileAccess.open(SCORE_SAVE_PATH, FileAccess.WRITE)
	var data = {
		"highest_score": highest_score
	}
	var json_string = JSON.stringify(data)
	file.store_line(json_string)
	
func load_highest_score():
	var file = FileAccess.open(SCORE_SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SCORE_SAVE_PATH):
		if not file.eof_reached():
			var line = file.get_line()
			var current_line = JSON.parse_string(line)
			if current_line:
				highest_score = current_line["highest_score"]
