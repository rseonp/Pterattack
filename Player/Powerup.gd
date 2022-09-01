extends Area2D

func _process(delta):
	position.y += Globals.speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

# Player (body)
func _on_Powerup_body_entered(_body):
	SoundFX.play("Powerup", rand_range(0.8, 1.1), -24)
	Globals.powerup_level += 1
	queue_free()
