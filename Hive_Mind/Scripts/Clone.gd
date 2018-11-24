extends Area2D

signal Died


export (String) var unit_type
var move_speed = 1
var health = 8
var attack
var attack_speed
var attack_range
var unit_cost
var debuffs = []
var upgrades = 0
var able_upgrade = true

func _ready():
	match unit_type:
		"red":
			attack = 2
			attack_speed = 1
			attack_range = 2
			unit_cost = 20
		"blue":
			attack = "slow"
			attack_speed = 1
			attack_range = 3
			unit_cost = 30
		"green":
			attack = "poison"
			attack_speed = 1
			attack_range = 1
			unit_cost = 40
		"yellow":
			attack = -8
			attack_speed = 1
			attack_range = 5
			unit_cost = 100
		"purple":
			attack = 3 + 1
			attack_speed = 1
			attack_range = 2
			unit_cost = 60
	
	if unit_type != null:
		get_node("Sprite").get_node("AnimationPlayer").play(unit_type + "_down")
	
	print(unit_cost)
	
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
