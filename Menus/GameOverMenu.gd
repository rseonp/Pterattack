extends CenterContainer

func _ready():
	pass
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		PlayerStats.reset()
		Globals.global_speed_factor = 1
		get_tree().change_scene("res://World/World.tscn")
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
