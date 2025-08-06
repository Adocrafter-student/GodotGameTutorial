extends AnimatableBody2D


@export var speed: float = 2.0
@export var distance: float = 100.0
@onready var freezable: Freezable = $Freezable

var start_y: float
var target_y: float

func _ready():
	start_y = position.y
	target_y = start_y + distance
	TFreezeController.register(freezable)

func _physics_process(delta):
	if freezable.frozen:
		return
	var new_y = lerp(position.y, target_y, delta * speed)
	
	position.y = new_y

	# When the platform is close to its target, switch the target.
	if abs(position.y - target_y) < 1.0:
		if target_y == start_y:
			target_y = start_y + distance
		else:
			target_y = start_y
