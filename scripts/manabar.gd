# ManaBar.gd
extends TextureProgressBar

# This exports a variable to the Godot editor.
# We need a reference to the same StatsComponent.
@export var stats_component : Node

# This function is called when the node enters the scene tree.
func _ready():
	# Make sure a StatsComponent was assigned in the editor.
	if not stats_component:
		print("ERROR: StatsComponent not assigned to the mana bar in the Inspector!")
		return

	# Set the initial value of the mana bar.
	# The line below needs to be updated to pass the initial mana value.
	update_mana_bar(stats_component.current_mana)
	
	# Connect to the StatsComponent's "mana_changed" signal.
	stats_component.mana_changed.connect(update_mana_bar)

func update_mana_bar(new_mana):
	# ALSO CHANGE THIS LINE to use the "new_mana" variable.
	value = (new_mana * 100) / stats_component.max_mana
