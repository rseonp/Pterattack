extends Node

var speed = 100

var bash_factor = 10
var bash_damage = 8

var roll_factor = 6

var shield_factor = 0.2

var fire_wait_timer = .20
var missile_speed = 200

#Energy
var max_energy = 100
var energy = max_energy setget set_energy

#Energy costs
var laser_energy_cost = .33
var bash_energy_cost = 4
var roll_energy_cost = 2
var shield_energy_cost_per_sec = 2
var existence_energy_cost = .5

signal player_energy_changed(value)
signal player_died

func reset():
	self.energy = max_energy

func set_energy(value):
	energy = clamp(value, 0, max_energy)
	emit_signal("player_energy_changed", energy)
	if energy == 0:
		emit_signal("player_died")
