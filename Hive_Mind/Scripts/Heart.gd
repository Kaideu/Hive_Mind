extends AnimatedSprite

var hits = 13.0

export (float) var HP_min
export (float) var HP_max

## needs to be a global value reference from player HP and constantly updated
onready var Health = Global.health

func _ready():
	# connect the pressed signal to the 
	owner.connect("Damage_Player", self, "_receive_damage")
	check_health_upgrade()

func _process(delta):
	Health = Global.health
	if Health < HP_min:
		hits = 0
	if Health >= HP_min and Health <= HP_max:
		hits = int(Health - HP_min)
	if Health >= HP_max:
		hits = 13
	animation = str(hits)
	

func check_health_upgrade():
	if Global.MaxHealth > HP_min:
		show()
	elif Global.MaxHealth <= HP_min:
		hide()

func _receive_damage(x):
	Health -= x
	Global.health = Health
