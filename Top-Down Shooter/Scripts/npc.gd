extends CharacterBody2D

@onready var body = $Body
@onready var arm_1 = $Body/Arm1
@onready var arm_2 = $Body/Arm2
@onready var gun = $Body/Arm1/Gun
@onready var life_amount = $Life_Amount
@onready var shoot_pos = $Body/Arm1/Gun/ShootPos
@onready var bullet_timer = $BulletTimer
@onready var player_detect = $PlayerDetect
@onready var wary_timer = $WaryTimer

var bullet = preload("res://Objects/enemyBullet.tscn")

var lives:int
var playerSeen := false

enum {
	IDLE,
	WARY,
	ENGAGED
}
var state = IDLE

@export_category("SETTINGS")
@export var max_lives:int
@export var friendly:bool = true
@export var killable:bool = true
@export var isStatic:bool = false
@export var player:CharacterBody2D

func _ready():
	lives = max_lives

func _process(delta):
	# If lives = 0, delete
	if lives == 0:
		queue_free()
	
	# Display the life_amount above head
	life_amount.text = str(lives)
	
	# If not killable and friendly, do not display the life amount
	if !killable:
		life_amount.visible = false
	
	# If friendly, make it look friendly
	if friendly:
		body.color = Color(0.1,0.75,0.1,1)
		arm_1.color = Color(0.1,0.75,0.1,1)
		arm_1.size.x = 10
		gun.visible = false
		arm_2.color = Color(0.1,0.75,0.1,1)
	# Otherwise, don't
	else:
		body.color = Color (0.8,0,0,1)
		arm_1.color = Color (0.8,0,0,1)
		arm_1.size.x = 39
		arm_1.position.x = 27
		arm_1.position.y = 40
		arm_1.rotation_degrees = -4
		gun.visible = true
		arm_2.color = Color (0.8,0,0,1)
	
	randomize_movement()
	stateMonitor(delta)

func loadBullet():
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = shoot_pos.global_position
	bullet_instance.rotation = shoot_pos.global_rotation
	get_parent().add_child(bullet_instance)

func stateMonitor(delta):
	if !friendly:
		if state == IDLE:
			print("IDLE")
		elif state == WARY:
			print("WARY")
		elif state == ENGAGED:
			print("ENGAGED")
			if playerSeen:
				rotateToPlayer(player, 1.0, delta)

func rotateToPlayer(target:CharacterBody2D, speed:float, delta):
	var rotation_speed = PI

	# Get veector from enemy to player
	var v = target.global_position - global_position
	# Get angle of that enemy
	var angle = v.angle()
	var r = global_rotation
	# Get rotation allowed this frame
	var angle_delta = rotation_speed * delta
	# Get complete rotation to player
	angle = lerp_angle(r, angle, speed)
	# Limit that rotation to what is allowed this frame
	angle = clamp(angle, r - angle_delta, r + angle_delta)
	# Set enemy rotation
	global_rotation = angle


func _on_bullet_collision_body_entered(body):
	if body.is_in_group("bullets"):
		if killable:
			lives -= 1
			
		if state != ENGAGED:
			look_at(body.global_position)
			state = WARY
			wary_timer.start()
	
		body.queue_free()


func _on_player_detect_body_entered(body):
	if body.is_in_group("player"):
		playerSeen = true
		state = ENGAGED
		if wary_timer.time_left != 0:
			wary_timer.stop()


func _on_player_detect_body_exited(body):
	if body.is_in_group("player"):
		playerSeen = false
		state = WARY
		wary_timer.start()


func _on_bullet_timer_timeout():
	if !friendly and playerSeen == true:
		loadBullet()


func _on_wary_timer_timeout():
	state = IDLE

# Movement (fucking kill me please oh my fucking days)
func _physics_process(delta):
	if state == IDLE:
		if !isStatic:
			pass
		else:
			velocity = Vector2(0,0)
	
	move_and_slide()

func randomize_movement():
	var randPos := Vector2(randi_range(-500, 500),randi_range(-500, 500))
	print(randPos)
