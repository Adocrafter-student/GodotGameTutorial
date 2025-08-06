# TimeFreezeController.gd
extends Node
class_name TimeFreezeController

# This array will hold a reference to every freezable node in the game.
var registered_nodes: Array[Freezable] = []

# --- Registration ---
func register(node: Freezable) -> void:
	# Add the node to our list if it's not already there.
	if not registered_nodes.has(node):
		registered_nodes.append(node)

func unregister(node: Freezable) -> void:
	# Remove the node from our list if it exists.
	if registered_nodes.has(node):
		registered_nodes.erase(node)

# --- Global Controls ---
func freeze_all() -> void:
	print("FREEZING TIME")
	# Tell every registered node to freeze.
	for node in registered_nodes:
		node.set_frozen(true)

func unfreeze_all() -> void:
	print("UNFREEZING TIME")
	# Tell every registered node to unfreeze.
	for node in registered_nodes:
		node.set_frozen(false)
