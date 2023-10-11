extends CharacterBody2D


var health = 100
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var isAttacking = false
var has_double_jumped = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimationPlayer")

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		isAttacking = true
		anim.play("Attack")
		await anim.animation_finished
		isAttacking = false

func _physics_process(delta):
	var lastHealth = health
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		has_double_jumped = false

	# Handle Jump.
	if Input.is_action_just_pressed("ui_up") and (is_on_floor() || not has_double_jumped):
		if not is_on_floor():
			has_double_jumped = true
		velocity.y = JUMP_VELOCITY	
		anim.play("Jump")
	
	if(velocity.y < 0):
		anim.play("Jump")
	if velocity.y > 0:
		anim.play("Fall")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED	
		if(velocity.y == 0):
			anim.play("Run")
		get_node("AnimatedSprite2D").flip_h = direction < 0
	else:	
		if lastHealth == health:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if(velocity.y == 0 && not isAttacking):
			anim.play("Idle")


	move_and_slide()
