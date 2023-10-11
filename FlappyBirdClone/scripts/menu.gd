extends Node2D

func _ready():
	Score.load_highest_score();

func _on_texture_button_pressed():
	Global.state = Global.STATES.ALIVE
	get_tree().change_scene_to_file("res://scenes/main.tscn")
