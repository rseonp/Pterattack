extends Node2D

const Enemy = preload("res://Enemy/Enemy.tscn")

onready var spawnPoints = $SpawnPoints
onready var spawnTimer = $Timer

func _process(_delta):
	spawnTimer.set_wait_time(Globals.spawn_wait_time / Globals.global_speed_factor)

func get_spawn_position():
	var points = $SpawnPoints.get_children()
	#test more narrow
#	var points = $SpawnPoints.get_children().slice(3,6)
	points.shuffle()
	return points[0].global_position
	
func spawn_enemy():
	var spawn_position = get_spawn_position()
	var enemy = Utils.instance_scene_on_main(Enemy, spawn_position)
	var rand = rand_range(0,1)
	
	#3 sizes of enemies
	if rand < 0.1:
		enemy.init(3)
	elif rand < 0.4:
		enemy.init(2)

func _on_Timer_timeout():
	spawn_enemy()
