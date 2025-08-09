# TimeFreezeController.gd
extends Node
class_name TimeFreezeController

# This array will hold a reference to every freezable node in the game.
var registered_nodes: Array[Freezable] = []

func reset() -> void:
	print("Resetting TimeFreezeController. Clearing all registered nodes.")
	registered_nodes.clear
# --- Registration ---
func register(node: Freezable) -> void:
	# Add the node to our list if it's not already there.
	if not registered_nodes.has(node):
		registered_nodes.append(node)

func unregister(node: Freezable) -> void:
	# Remove the node from our list if it exists.
	if registered_nodes.has(node):
		registered_nodes.erase(node)

# --- Global Controls (Now with safety checks) ---
func freeze_all() -> void:
	print("FREEZING TIME")
	# We iterate backwards to safely allow unregistering during the loop if needed.
	for i in range(registered_nodes.size() - 1, -1, -1):
		var node = registered_nodes[i]
		# SAFETY CHECK: Make sure the node hasn't been freed.
		if is_instance_valid(node):
			node.set_frozen(true)
		else:
			# If the node is invalid, remove its dangling reference.
			registered_nodes.remove_at(i)


func unfreeze_all() -> void:
	print("UNFREEZING TIME")
	for i in range(registered_nodes.size() - 1, -1, -1):
		var node = registered_nodes[i]
		# SAFETY CHECK: Make sure the node hasn't been freed.
		if is_instance_valid(node):
			node.set_frozen(false)
		else:
			# If the node is invalid, remove its dangling reference.
			registered_nodes.remove_at(i)
