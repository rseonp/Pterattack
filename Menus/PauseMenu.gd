extends ColorRect

var paused = false setget set_paused

func set_paused(value):
	paused = value
	get_tree().paused = paused
	visible = paused
	
	if paused:
		SoundFX.play("Pause", 1, -27)
	else:
		SoundFX.play("Unpause", 1, -27)

func _process(_delta):
	var player_is_alive = get_tree().get_nodes_in_group("Player").size() > 0
	if Input.is_action_just_pressed("pause") and player_is_alive:
		self.paused = !paused
