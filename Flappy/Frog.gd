extends CharacterBody2D

const SPEED = 50
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var chase = false
var dead = false
var respawnTime = 0

@onready var frog = get_node("AnimatedSprite2D")
@onready var deadCollisionBox = get_node('FrogDeath')
@onready var playerCollisionBox = get_node('PlayerCollision')
@onready var frogCollisionBox = get_node('FrogCollisionShape')
@onready var player = get_node("../../Player")


func _process(delta):
	if(respawnTime != 0 && Time.get_time_dict_from_system().second - respawnTime > 3):
		dead = false
		add_child(deadCollisionBox)
		add_child(frogCollisionBox)
		add_child(playerCollisionBox)
		add_child(self)
		

func _physics_process(delta):
	# Add the gravity.	
	if not dead:
		velocity.y += gravity * delta
		if chase:
			frog.play('Jump')
			var dir = (player.position-self.position).normalized()
			frog.flip_h = dir.x > 0
			velocity.x = dir.x * SPEED
		else:
			velocity.x = 0
			frog.play('Idle')
	
	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true



func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false


func _on_frog_death_body_entered(body):
	if body.name == "Player":
		death()
		body.velocity.y = -200
		


func _on_player_collision_body_entered(body):
	if body.name == "Player":
		body.health -= 5
		death()

func death():
	respawnTime = Time.get_time_dict_from_system().second
	dead = true;
	deadCollisionBox.queue_free()
	frogCollisionBox.queue_free()
	playerCollisionBox.queue_free()
	frog.play('Death')
	await frog.animation_finished
	self.queue_free()
