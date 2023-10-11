extends Label

@onready var player = get_node('../../Player')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "HP: " + str(player.health)
