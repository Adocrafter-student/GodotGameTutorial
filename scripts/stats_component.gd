# StatsComponent.gd
extends Node

## Emitted when health changes. Passes the new health value.
signal health_changed(new_health)
## Emitted when mana changes. Passes the new mana value.
signal mana_changed(new_mana)
## Emitted when health reaches zero.
signal died

@export var max_health: float = 100.0
@export var current_health: float

@export var max_mana: float = 100.0
@export var current_mana: float

func _ready():
	# Initialize stats
	current_health = max_health
	current_mana = max_mana

func take_damage(amount: float):
	current_health -= amount
	current_health = max(current_health, 0) # Prevents health from going below 0
	
	health_changed.emit(current_health)
	
	if current_health == 0:
		died.emit()

func drain_mana(amount: float):
	current_mana -= amount
	current_mana = max(current_mana, 0) # Prevents mana from going below 0

	mana_changed.emit(current_mana)

func has_enough_mana(amount: float) -> bool:
	return current_mana >= amount
