extends Node

var sounds_path = "res://Music and Sounds/"

var sounds = {
	"Laser": load(sounds_path + "Laser.wav"),
	"Hit": load(sounds_path + "Hit.wav"),
	"Hurt": load(sounds_path + "Hurt.wav"),
	"Pause": load(sounds_path + "Pause.wav"),
	"Unpause": load(sounds_path + "Unpause.wav"),
	"Click": load(sounds_path + "Click.wav"),
	"Explosion": load(sounds_path + "Explosion.wav"),
	"EnemyDie": load(sounds_path + "EnemyDie.wav"),
	"Powerup": load(sounds_path + "Powerup.wav"),
	"ShipHit": load(sounds_path + "ShipHit.wav"),
	"Explode": load(sounds_path + "Explode.wav"),
}

onready var sound_players = get_children()

func play(sound_string, pitch_scale = 1, volume_db = -16):
	for soundPlayer in sound_players:
		if not soundPlayer.playing:
			soundPlayer.pitch_scale = pitch_scale
			soundPlayer.volume_db = volume_db
			soundPlayer.stream = sounds[sound_string]
			soundPlayer.play()
			return
	print("TOO MANY SOUNDS PLAYING AT ONCE")
