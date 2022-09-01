extends "res://Player/Projectile.gd"

func _ready():
	velocity = Vector2.UP * PlayerStats.missile_speed
