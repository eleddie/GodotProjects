extends ParallaxBackground

var scrolling_speed = 220

func _process(delta):
	if Global.state == Global.STATES.DEAD:
		return
	scroll_offset.x -= scrolling_speed * delta
	move_child($BaseParallaxLayer, get_child_count()-1)


func _on_floor_body_entered(body):
	if body.name == "Bird":
		Global.main.on_die()
