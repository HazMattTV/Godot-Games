extends CharacterBody2D

@onready var life_amount = $Life_Amount
@onready var shoot_pos = $Body/Arm1/Gun/ShootPos

const MAX_SPEED = 400.0
const ACCEL = 50.0

@export_category("SETTINGS")
@export var killable := true
@export var max_lives := 0

var lives
var bullet = preload("res://Objects/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	lives = max_lives

func _process(delta):
	# If the shoot button is pressed, load a bullet
	if Input.is_action_just_pressed("shoot"):
		load_bullet()
	
	# If the player's lives is 0, delete it from the scene
	if lives == 0:
		queue_free()
		
	# Look at mouse
	look_at(get_global_mouse_position())
	
	# Draw Lives on screen
	life_amount.text = str(lives)
	
	if !killable:
		life_amount.visible = false

func _physics_process(delta):
	# Movement
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if !Input.is_action_pressed("sprint"):
		velocity.x = move_toward(velocity.x, MAX_SPEED * direction.x, ACCEL)
		velocity.y = move_toward(velocity.y, MAX_SPEED * direction.y, ACCEL)
	
	move_and_slide()

# Loading the bullet into world
func load_bullet():
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = shoot_pos.global_position
	bullet_instance.rotation = shoot_pos.global_rotation
	get_parent().add_child(bullet_instance)

# If the player detects a bullet
func _on_bullet_detect_body_entered(body):
	if killable and body.is_in_group("enemy_bullets"):
		lives -= 1
