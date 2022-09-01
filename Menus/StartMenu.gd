extends Node

func _ready():
	VisualServer.set_default_clear_color(Color.black)

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		SoundFX.play("Click")
		get_tree().change_scene("res://World/World.tscn")
	if Input.is_action_just_pressed("ui_cancel"):
		SoundFX.play("Click")
		get_tree().quit()
