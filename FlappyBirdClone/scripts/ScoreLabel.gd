extends Node2D

var num0 = preload("res://assets/sprites/0.png")
var num1 = preload("res://assets/sprites/1.png")
var num2 = preload("res://assets/sprites/2.png")
var num3 = preload("res://assets/sprites/3.png")
var num4 = preload("res://assets/sprites/4.png")
var num5 = preload("res://assets/sprites/5.png")
var num6 = preload("res://assets/sprites/6.png")
var num7 = preload("res://assets/sprites/7.png")
var num8 = preload("res://assets/sprites/8.png")
var num9 = preload("res://assets/sprites/9.png")

var arr = [num0, num1, num2, num3, num4, num5, num6, num7, num8, num9]
const NUMBER_SIZE = 26
const HALF_SIZE = NUMBER_SIZE / 2 
var initialPosition
	
func _ready():
	initialPosition = $"0".position
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for child in get_children():
		child.queue_free()
	var isHighScore = get_meta("isHighScore")
	var score = Score.highest_score if isHighScore else Score.current_score 
	var chars = str(score).length()
	# Loop through each digit of the score
	for i in range(chars):
		# Get the digit
		var digit = int(str(score)[i])
		# create the sprite node
		var sprite = Sprite2D.new()
		# Add the sprite node as a child of the score node
		add_child(sprite)
		# Set the position of the sprite node
		sprite.position = Vector2(initialPosition.x - (NUMBER_SIZE * (chars-1-i)), initialPosition.y)
		# Set the sprite texture
		sprite.texture = arr[digit]
