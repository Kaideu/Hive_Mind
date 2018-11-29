extends Area2D

export (int) var Player_Speed = 200

var walk = false

var health = 6.5
var attack
var attack_speed
var attack_range = 5
var respawn_time = 30
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
	
	
	
	pass
