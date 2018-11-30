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

var ready = false

func _ready():
	health = MaxHealth
	
	# Match the unit type and assign the stat values accordingly
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
	
	# Check that the unit type is assigned and access the main sprite node
	if unit_type != null:
		$Sprite_Main/Anim.play(unit_type + "_form")
	
	# wait for the spawning animation to finish to allow any interaction, notified by ready boolean.
	yield($TimerClick, "timeout")
	ready = true
	if ready:
		print("Ready: " + unit_type + " " + get_name())


func _input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("Place_Piece") and ready:
		print("Clicked " + unit_type + " " + get_name())
		Damaged()

func Damaged():
	health -= 1
	print(health)

func _Died():
	print("Dropping Resource: " + unit_type + " " + get_name())
	queue_free()

func _process(delta):
	if health <= 0:
		_Died()
	if health > 0 and health < MaxHealth:
		$Sprite_Damage.show()
		var Damage = float((MaxHealth - health)/2)
		$Sprite_Damage/Anim.play("Damage_" + str(int(Damage)))
		if debuffs.has("slow"):
			$Sprite_Main/Anim.playback_speed = (3.0/Damage)/2
		elif !debuffs.has("slow"):
			$Sprite_Main/Anim.playback_speed = 3.0/Damage
		

#This is for the identification of the instance. using has_method(), this will be identified has a Clone
func _is_Clone():
	pass
