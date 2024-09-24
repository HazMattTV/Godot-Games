extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -200.0

@export_category("PLAYER COORDS")
@export var x:int
@export var y:int

@onready var animation_player = $AnimationPlayer
@onready var death_particle = $death_particle
@onready var sprite = $AnimatedSprite2D
@onready var death_flash = $"../Death_Flash"
@onready var DF_animation_player = $"../Death_Flash/AnimationPlayer"

#SFX
@onready var flap = $SFX/Flap
@onready var hit = $SFX/Hit
@onready var death = $SFX/Death


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	position.x = x
	position.y = y

func _physics_process(delta):
	if Global.player_ready == true:
		play_anim()
		
	if Input.is_action_just_pressed("jump"):
		Global.player_ready = false
		Global.playing = true
		sprite.offset.y = 0
	
	# If the bird didn't hit anything
	if Global.game_over == false and Global.player_ready == false:
		# Apply Gravity
		if !is_on_floor():
			velocity.y += gravity * delta

		# Handle jump.
		if Input.is_action_just_pressed("jump") and (!is_on_floor() || is_on_floor()):
			velocity.y = -200.0
			velocity.y = JUMP_VELOCITY
			flap.play()
			animation_player.play("flap");
	# Otherwise
	else:
		# Set it's velocity to 0
		velocity.x = 0
		velocity.y = 0

	move_and_slide()

func play_anim():
	# If the player is ready to play
	if Global.player_ready == true:
		# Play the Animation
		animation_player.play("flying_anim")

func _on_collision_detect_body_entered(body):
	# When the player collides something, set Global.playing to false and
	# Global.game_over to true
	Global.playing = false
	Global.game_over = true
	# Play hit and death SFX
	hit.play()
	death.play()
	# Set the sprite visibility to false
	sprite.visible = false  
	# Emit a death particle that falls off the screen
	death_particle.emitting = true
	
	# If the score is above your best score, set it as the best score
	if Global.points > Global.best_score:
		Global.best_score = Global.points
	
	# Show Death Flash Screen
	death_flash.visible = true
	DF_animation_player.play("death_flash")
	await DF_animation_player.animation_finished
	DF_animation_player.stop()
	death_flash.visible = false
