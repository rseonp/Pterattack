extends HBoxContainer

onready var label = $Label

func _ready():
	pass
#	PlayerStats.connect("player_missiles_changed", self, "_on_Player_missiles_changed")
#	PlayerStats.connect("player_missiles_unlocked", self, "_on_Player_missiles_unlocked")
	
func _on_Player_missiles_changed(value):
	label.text = str(value)
	
func _on_Player_missiles_unlocked(value):
	visible = value
