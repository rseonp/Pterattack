extends Control

onready var full = $Full

func _ready():
	PlayerStats.connect("player_health_changed", self, "_on_Player_health_changed")
	
func _on_Player_health_changed(value):
	full.rect_size.x = value * 5 + 1
