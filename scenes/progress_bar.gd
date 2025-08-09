extends TextureProgressBar

# This exports a variable to the Godot editor.
# We now need a reference to the StatsComponent, NOT the player.
@export var stats_component : Node

# This function is called when the node enters the scene tree.
func _ready():
	# Make sure a StatsComponent was assigned in the editor.
	if not stats_component:
		print("ERROR: StatsComponent not assigned to the health bar in the Inspector!")
		return

	# Set the initial value of the health bar.
	update_health_bar()
	
	# Connect to the StatsComponent's "health_changed" signal.
	stats_component.health_changed.connect(update_health_bar)

# This function updates the visual of the health bar.
# It now gets its data from the stats_component.
func update_health_bar():
	value = (stats_component.current_health * 100) / stats_component.max_health
