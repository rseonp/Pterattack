extends KinematicBody2D

const ExplosionEffect = preload("res://Effects/ExplosionEffect.tscn")
const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

const projectiles = {
	"Laser_1": preload("res://Player/Laser_1.tscn")
}

export(int) var missile_speed = 400

enum {
	NONE,
	BASH,
	SHIELD,
	ROLL
}

var invincible = false setget set_invincible
var velocity = Vector2.ZERO

var action = NONE
var is_holding_shield = false
var is_holding_up = false
var is_holding_down = false

onready var hitbox = $Hitbox
onready var blinkAnimator = $BlinkAnimator
onready var actionAnimator = $ActionAnimator

onready var fireTimer = $FireTimer
onready var existenceTimer = $ExistenceTimer
onready var shieldTimer = $ShieldTimer
onready var upDownTimer = $UpDownTimer

func _ready():
	fireTimer.set_wait_time(PlayerStats.fire_wait_timer)
	PlayerStats.connect("player_died", self, "_on_Player_player_died")
	hitbox.damage = PlayerStats.bash_damage
	
func _physics_process(_delta):
	velocity = get_input_vector()

	if Input.is_action_pressed("shoot") and fireTimer.time_left == 0:
		fire_laser()
	elif Input.is_action_just_pressed("action"):
		if velocity.y == -1:
			bash()
		elif velocity == Vector2.RIGHT or velocity == Vector2.LEFT:
			roll()
		elif velocity == Vector2.DOWN:
			shield()
	
	if Input.is_action_pressed("action"):
		if is_holding_shield:
			shield()
	elif Input.is_action_just_released("action") and is_holding_shield:
		is_holding_shield = false
		action = NONE
			
	if velocity == Vector2.ZERO:
		velocity = Globals.default_vector * Globals.global_speed_factor
	elif velocity != Vector2.ZERO and action == NONE:
		velocity = velocity.normalized()

	velocity *= PlayerStats.speed
	
	if is_holding_up and Globals.global_speed_factor > 1:
		velocity /= Globals.global_speed_factor
	
	if action != SHIELD:
		action = NONE
#	if action == NONE or action == SHIELD:
#	else:
#		action = NONE
		
	velocity = move_and_slide(velocity)

func get_input_vector():
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		if not is_holding_down and not is_holding_up:
			upDownTimer.start(1)
			is_holding_down = true
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		if not is_holding_up and not is_holding_down:
			upDownTimer.start(1)
			is_holding_up = true
		input_vector.y -= 1
	if Input.is_action_just_released("ui_up") and is_holding_up:
		upDownTimer.stop()
		is_holding_up = false
	if Input.is_action_just_released("ui_down") and is_holding_down:
		upDownTimer.stop()
		is_holding_down = false
	
	return input_vector
	
func fire_laser():
	SoundFX.play("Laser", rand_range(0.6, 1.1))
	PlayerStats.energy -= PlayerStats.laser_energy_cost
	
	if Globals.powerup_level == 1:
		Utils.instance_scene_on_main(projectiles["Laser_1"], global_position)
	elif Globals.powerup_level == 2:
		Utils.instance_scene_on_main(projectiles["Laser_1"], Vector2(global_position.x - 3, global_position.y))
		Utils.instance_scene_on_main(projectiles["Laser_1"], Vector2(global_position.x + 3, global_position.y))
	elif Globals.powerup_level == 3:
		Utils.instance_scene_on_main(projectiles["Laser_1"], Vector2(global_position.x - 6, global_position.y))
		Utils.instance_scene_on_main(projectiles["Laser_1"], Vector2(global_position.x, global_position.y))
		Utils.instance_scene_on_main(projectiles["Laser_1"], Vector2(global_position.x + 6, global_position.y))
	elif Globals.powerup_level == 4:
		Utils.instance_scene_on_main(projectiles["Laser_1"], Vector2(global_position.x - 9, global_position.y))
		Utils.instance_scene_on_main(projectiles["Laser_1"], Vector2(global_position.x - 3, global_position.y))
		Utils.instance_scene_on_main(projectiles["Laser_1"], Vector2(global_position.x + 3, global_position.y))
		Utils.instance_scene_on_main(projectiles["Laser_1"], Vector2(global_position.x + 9, global_position.y))
#	Utils.instance_scene_on_main(projectiles[Globals.power + "_" + str(Globals.powerup_level)], global_position)	
	
	fireTimer.start()
	
func bash():
	action = BASH
	actionAnimator.play("Bash")
	velocity *= PlayerStats.bash_factor
	PlayerStats.energy -= PlayerStats.bash_energy_cost

func roll():
	action = ROLL
	actionAnimator.play("Roll")
	velocity *= PlayerStats.roll_factor
	PlayerStats.energy -= PlayerStats.roll_energy_cost

func shield():
	action = SHIELD
	is_holding_shield = true
	if shieldTimer.time_left == 0:
		shieldTimer.start()
#	actionAnimator.play("Shield")
	blinkAnimator.play("Blink")
	velocity *= PlayerStats.shield_factor

func set_invincible(value):
	invincible = value

func _on_Player_player_died():
	SoundFX.play("Explode")
	Utils.instance_scene_on_main(ExplosionEffect, Vector2(global_position.x, global_position.y + 5))
	Utils.instance_scene_on_main(EnemyDeathEffect, global_position)
	queue_free()

func _on_Hurtbox_hit(damage):
	if not invincible:
		#depending on what is colliding
		SoundFX.play("Hurt", rand_range(0.8, 1.0), -21)
#		PlayerStats.health -= damage
		PlayerStats.energy -= damage
		blinkAnimator.play("Blink")

func _on_ExistenceTimer_timeout():
	PlayerStats.energy -= PlayerStats.existence_energy_cost
	existenceTimer.start()

func _on_ShieldTimer_timeout():
	PlayerStats.energy -= PlayerStats.shield_energy_cost_per_sec
	if is_holding_shield:
		shieldTimer.start()

func _on_UpDownTimer_timeout():
	if is_holding_up:
		Globals.global_speed_factor += .5
		upDownTimer.start()
	if is_holding_down:
		Globals.global_speed_factor -= .5
		upDownTimer.start()
