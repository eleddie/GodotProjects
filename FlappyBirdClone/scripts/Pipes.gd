extends Area2D


var SPEED = 220
var was_already_activated = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.state == Global.STATES.DEAD:
		return
	position.x -= delta * SPEED

func remove_pipes():
	self.queue_free()


func _on_body_entered(body):
	if body.name == "Bird":
		Global.main.on_die()


func _on_pipes_passed_area_2d_body_entered(body):
	if not was_already_activated:
		was_already_activated = true
		$PointSound.play()
		Score.current_score += 1
		if Score.current_score > Score.highest_score:
			Score.increase_highest_score()
