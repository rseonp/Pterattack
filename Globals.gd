extends Node

var global_speed_factor = 1 setget set_global_speed_factor

#level
var default_vector = Vector2(0, 0.2)

var speed = 50
var spawn_wait_time = .55
var power = "Laser" setget set_power
var powerup_chance = .05
var powerup_level = 1 setget set_powerup_level
var max_powerup_level = 4

signal gsf_changed
	
func set_global_speed_factor(value):
	global_speed_factor = clamp(value, .25, 4)
	emit_signal("gsf_changed")
	
func set_powerup_level(value):
	if value <= max_powerup_level:
		powerup_level = value
	
func set_power(value):
	power = value
	
#var PlayerStats = preload("res://Player/PlayerStats.tres")
#var MainInstances = preload("res://MainInstances.tres")
