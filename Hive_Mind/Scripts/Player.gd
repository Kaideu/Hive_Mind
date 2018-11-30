extends Area2D

signal dead

export (int) var Player_Speed = 200

var walk = false

var health
var attack
var attack_speed
var attack_range = 5
var respawn_time = 3
onready var count = respawn_time
var gather_speed = 5
var debuffs = []

#var up
#var down
#var left
#var right

func _ready():
	$RespawnTimer.wait_time = respawn_time
	$GatherTimer.wait_time = gather_speed
#	up = Input.is_action_pressed("ui_up")
#	down = Input.is_action_pressed("ui_down")
#	left = Input.is_action_pressed("ui_left")
#	right = Input.is_action_pressed("ui_right")

func walk():
	$Sprite/Anim.current_animation = ("walk")

func get_input(v):
	v = Vector2()
	if !Global.dead:
		if Input.is_action_pressed("ui_up"):
			v.y -= 1
		if Input.is_action_pressed("ui_down"):
			v.y += 1
		if Input.is_action_pressed("ui_left"):
			v.x -= 1
			$Sprite.flip_h = false
		if Input.is_action_pressed("ui_right"):
			v.x += 1
			$Sprite.flip_h = true
	return v

func get_current_speed():
	var s = Player_Speed
	return s

func _process(delta):
	var velocity = Vector2()
	var speed = get_current_speed()
	velocity = get_input(velocity)
	if velocity == Vector2(0,0):
		$Sprite/Anim.current_animation = ("idle")
	elif velocity != Vector2(0,0):
		walk()
	position += velocity.normalized() * delta * speed
	health = Global.health
	if health <= 0 and !Global.dead:
		emit_signal("dead", true)
		respawn()
	$Sprite/Anim.playback_speed = 3.0*(health/Global.MaxHealth)
	

func respawn():
	$RespawnTimer.start()
	$RespawnCount.start()
	hide()
	$Collider.disabled = true
	countdown()
	yield($RespawnTimer, "timeout")
	Global.health = Global.MaxHealth
	position = Global.Spawn_point
	$Sprite/Anim.current_animation = ("idle")
	$Collider.disabled = false
	show()
	emit_signal("dead", false)
	#need to change dead to false without code breaking here

func countdown():
	if count == 0:
		$RespawnCount.stop()
	else:
		print("Waiting for respawn in " + str(count))
		count -= 1
