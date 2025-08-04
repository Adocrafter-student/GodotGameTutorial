extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var is_attacking = false
var time_frozen = false

func _ready():
	# Connect the animation finished signal
	sprite.animation_finished.connect(_on_animation_finished)
	# Allow player to process even when paused
	process_mode = Node.PROCESS_MODE_ALWAYS

func _physics_process(delta: float) -> void:
	# Handle time freeze toggle
	if Input.is_action_just_pressed("special1"):
		toggle_time_freeze()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle attack input
	if Input.is_action_just_pressed("melee_attack") and not is_attacking:
		is_attacking = true
		sprite.play("attack")

	# Get the input direction and handle the movement/deceleration.
	# returns -1, 0 and 1.
	var direction := Input.get_axis("move_left", "move_right")

	# Applies Movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	# Update animations after movement
	_update_animation(direction)

func _update_animation(dir: float) -> void:
	# Don't change animation if attacking
	if is_attacking:
		return

	# Priority: jump -> run -> idle
	if not is_on_floor():
		sprite.play("jump")
	elif dir != 0:
		sprite.flip_h = dir < 0
		sprite.play("run")
	else:
		sprite.play("idle")

func _on_animation_finished():
	if sprite.animation == "attack":
		is_attacking = false

func toggle_time_freeze():
	time_frozen = !time_frozen
	
	if time_frozen:
		get_tree().paused = true
		print("Time frozen!")
	else:
		get_tree().paused = false
		print("Time resumed!")
