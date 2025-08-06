extends Node2D
const MOVES_SPEED = 60
var direction = 1
@onready var freezable: Freezable = $Freezable

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	# Tell the global controller that this enemy is here and can be frozen.
	TFreezeController.register(freezable)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if freezable.frozen:
		return
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	position.x +=MOVES_SPEED * delta * direction

func _exit_tree():
	TFreezeController.unregister(freezable)
