extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var is_attacking = false
var time_is_frozen: bool = false
@onready var stats_component: Node = $StatsComponent
@export var time_freeze_cost_per_second: float = 20.0


func _ready():
	# Connect the animation finished signal
	sprite.animation_finished.connect(_on_animation_finished)
	stats_component.died.connect(_die)

func _physics_process(delta: float) -> void:
	# --- Time Freeze Logic (now using the component) ---
	if Input.is_action_just_pressed("special1"):
		# Ask the component if we have mana
		if not time_is_frozen and stats_component.has_enough_mana(1): # Check for at least 1 mana
			time_is_frozen = true
			TFreezeController.freeze_all()
		else:
			time_is_frozen = false
			TFreezeController.unfreeze_all()
	
	if time_is_frozen:
		# Tell the component to drain mana
		stats_component.drain_mana(time_freeze_cost_per_second * delta)
		
		# If the component reports 0 mana, stop freezing
		if stats_component.current_mana == 0:
			time_is_frozen = false
			TFreezeController.unfreeze_all()
		
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

func _die():
	print("Player has died!")
	queue_free()
