extends KinematicBody2D

signal dead

export (int) var Player_Speed = 200

var grounded = true
enum Layers {Walk = 0, Fly = 1}

var health
var attack
var attack_speed
var attack_range = 5
var respawn_time = 3
onready var count = respawn_time
var gather_speed = 5
var debuffs = []

func _ready():
	$RespawnTimer.wait_time = respawn_time
	$GatherTimer.wait_time = gather_speed
	Global.get_player()

func walk(OnGround):
	if OnGround:
		$Sprite/Anim.current_animation = ("walk")
	else:
		$Sprite/Anim.current_animation = ("fly")
	set_collision_layer_bit(Layers.Walk, OnGround)
	set_collision_layer_bit(Layers.Fly, !OnGround)

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
		if Input.is_action_just_pressed("fly"):
			if grounded:
				grounded = false
			elif !grounded:
				grounded = true
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
		walk(grounded)
	#position += velocity.normalized() * delta * speed
	var motion = velocity.normalized() * speed
	move_and_slide(motion, Vector2(0,-1))
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

func countdown():
	if count == 0:
		$RespawnCount.stop()
	else:
		print("Waiting for respawn in " + str(count))
		count -= 1
