# Freezable.gd
extends Node
class_name Freezable

var frozen: bool = false
var immune: bool = false

# This function is the "gate" that controls the freeze state.
func set_frozen(state: bool) -> void:
	# If this entity is immune, do nothing.
	if immune:
		return
	
	# Otherwise, update the state.
	frozen = state
