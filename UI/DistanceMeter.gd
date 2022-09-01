extends Control

onready var progressBar = $ProgressBar
onready var timer = $Timer

func _ready():
#	PlayerStats.connect("player_distance_changed", self, "_on_Player_energy_changed")
	timer.start()

func _on_Timer_timeout():
	progressBar.value += .025 * Globals.global_speed_factor
	if progressBar.value >= 100:
		yield(get_tree().create_timer(1.0), "timeout")
		PlayerStats.reset()
		Globals.global_speed_factor = 1.0
		get_tree().change_scene("res://Menus/StartMenu.tscn")
	else: 
		timer.start()
