# DamageComponent.gd
class_name DamageComponent
extends Area2D

## The amount of damage this entity will deal on contact.
@export var damage_amount: float = 10.0

# This function is called when a physics body enters this area.
func _on_body_entered(body: Node2D) -> void:
	# Check if the body that entered has our StatsComponent.
	# We use get_node_or_null to prevent errors if it doesn't.
	print("test test")
	var stats_component = body.get_node_or_null("StatsComponent")
	
	# If the stats_component was found...
	if stats_component:
		print("should take dmg")
		stats_component.take_damage(damage_amount)
	else:
		print("Nooooo")
