extends AnimatedSprite

var hits = 13.0

export (float) var HP_min
export (float) var HP_max

## needs to be a global value reference from player HP and constantly updated
onready var Health = Global.health

func _ready():
	# connect the pressed signal to the 
	owner.connect("Damage_Player", self, "_receive_damage")

func _process(delta):
	Health = Global.health
	if Health < HP_min:
		hits = 0.0
	if Health >= HP_min and Health <= HP_max:
		hits = int(Health - HP_min)
	animation = str(hits)
	


func _receive_damage(x):
	Health -= x
	Global.health = Health
