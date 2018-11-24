extends Area2D

signal Died


export (String) var unit_type
var team
var move_speed = 1
var MaxHealth = 8.0
var health
var attack
var attack_speed
var attack_range
var unit_cost
var debuffs = []
var upgrades = 0
var able_upgrade = true

func _ready():
	health = MaxHealth
	match unit_type:
		"red":
			attack = 2.0
			attack_speed = 1.0
			attack_range = 2
			unit_cost = 20
		"blue":
			attack = "slow"
			attack_speed = 1.0
			attack_range = 3
			unit_cost = 30
		"green":
			attack = "poison"
			attack_speed = 1.0
			attack_range = 1
			unit_cost = 40
		"yellow":
			attack = -8.0
			attack_speed = 1.0
			attack_range = 5
			unit_cost = 100
		"purple":
			attack = 3.0 + 1.0
			attack_speed = 1.0
			attack_range = 2
			unit_cost = 60
	
	if unit_type != null:
		get_node("Sprite").get_node("AnimationPlayer").play(unit_type + "_down")
	
	
	
func Damaged():
	health -= 1
	print(health)
	_CheckHP()

func _CheckHP():
	print("CheckingHP")
	if health < 8:
		$Health.show()
	else:
		$Health.hide()

func _Died():
	print("Drop Resource")
	queue_free()

func _process(delta):
	if health <= 0:
		_Died()
	if health > 0:
		$Health/Current.rect_scale.x = health/MaxHealth
	

