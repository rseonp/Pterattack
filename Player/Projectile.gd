extends Node2D

const ExplosionEffect = preload("res://Effects/ExplosionEffect.tscn")

var velocity = Vector2.ZERO

func _ready():
	pass
	
func _process(delta):
	position += velocity * delta

func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	queue_free()

func _on_Hitbox_area_entered(_area):
	Utils.instance_scene_on_main(ExplosionEffect, Vector2(global_position.x, global_position.y + 5))
	queue_free()
