extends Node2D


func _on_texture_rect_pressed():
	Score.current_score = 0
	get_tree().reload_current_scene()
