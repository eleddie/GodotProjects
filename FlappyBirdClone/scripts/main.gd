extends Node2D

var pipeScene = preload("res://scenes/Pipes.tscn")
var deadScene = preload("res://scenes/Dead.tscn")

var pipeMinY = 160
var pipeMaxY = 660
var pipesSpaceX = 360
var lastPipes


func _ready():
	Global.state = Global.STATES.ALIVE
	Global.main = self
	
	
func _on_timer_timeout():
	if Global.state == Global.STATES.DEAD:
		return
	var pipes = pipeScene.instantiate()
	$ParallaxBackground.add_child(pipes)
	pipes.position = Vector2(get_x(), get_random_y())
	pipes.z_index = 100
	lastPipes = pipes
	delete_pipes()

func delete_pipes():
	for child in get_children():
		if child.has_method("remove_pipes") and child.position.x < -100:
			child.remove_pipes()

func get_x():
	if lastPipes == null:
		return 574+100
	else:
		return lastPipes.position.x + pipesSpaceX

func get_random_y():
	return randf_range(pipeMinY, pipeMaxY)

func on_die():
	var dead = deadScene.instantiate()
	add_child(dead)
	Global.state = Global.STATES.DEAD
	$DieSound.play()
	Score.save_highest_score()

