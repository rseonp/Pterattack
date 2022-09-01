extends Node

onready var Player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	VisualServer.set_default_clear_color(Color.black)
	PlayerStats.connect("player_died", self, "_on_Player_player_died")
	
func _on_Player_player_died():
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().change_scene("res://Menus/GameOverMenu.tscn")
