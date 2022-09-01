extends Control

#onready var full = $Full
onready var progressBar = $ProgressBar

func _ready():
	PlayerStats.connect("player_energy_changed", self, "_on_Player_energy_changed")
	
func _on_Player_energy_changed(value):
	progressBar.value = value
#	full.rect_size.x = value * 5 + 1
