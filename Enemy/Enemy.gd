extends Area2D

const Powerup = preload("res://Player/Powerup.tscn")
const Energy = preload("res://World/Energy.tscn")
const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

export(int) var size = 1
var current_size = size

export(int) var health = 2
export(int) var power = 4

export(int) var base_health = 2
export(int) var base_power = 4

onready var hitbox = $Hitbox

func _ready():
	hitbox.damage = power
	
func _process(delta):
	position.y += Globals.speed * Globals.global_speed_factor * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Hurtbox_hit(damage):
	health -= damage
	if health <= 0:
		Utils.instance_scene_on_main(EnemyDeathEffect, global_position)
		if rand_range(0, 1) <= Globals.powerup_chance:
			Utils.instance_scene_on_main(Powerup, global_position)
			queue_free()
		else:
			var energy = Utils.instance_scene_on_main(Energy, global_position)
			energy.energy *= size
			energy.scale = Vector2(size, size)
			queue_free()
	elif health == base_health * (size - 1):
		downsize()

func downsize():
	power -= base_power
	current_size -= 1
	scale(current_size)

func scale(value):
	if value == 2:
		scale = Vector2(1.3, 1.3)
	elif value == 3:
		scale = Vector2(2, 2)
	else:
		scale = Vector2(1, 1)

func init(value):
	size = value
	current_size = value
	health = base_health * value
	power = base_power * value
	scale(value)
