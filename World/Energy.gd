extends Area2D

export(int) var energy = 1

func _process(delta):
	position.y += Globals.speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

# body is player (collision mask)
func _on_Energy_body_entered(_body):
	SoundFX.play("Click", .4, -24)
	PlayerStats.energy += energy
	queue_free()
