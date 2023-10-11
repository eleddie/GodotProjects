extends CharacterBody2D


const JUMP_VELOCITY = -350.0
const MAX_DEGREE_LIMIT: float = 45.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$BirdAnimatedSprite2D.play('fall')

func _physics_process(delta):
	if Global.state == Global.STATES.DEAD:
		return
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("mouse_left"):
		velocity.y = JUMP_VELOCITY
		$BirdAnimatedSprite2D.play('flap')
		$FlapTimer.start()
		$FlapSound.play()
	
	rotate_bird()

	move_and_slide()

func rotate_bird():
	var weight = 0.1 if velocity.y > 0 else 0.5
	rotation_degrees = lerp(float(rotation_degrees), float(clamp(velocity.y,-45, 45)), weight)


func _on_flap_timer_timeout():
	$BirdAnimatedSprite2D.play('fall')
	$FlapTimer.stop()
