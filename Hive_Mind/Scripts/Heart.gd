extends AnimatedSprite

var hits = 13

export (int) var HP_min
export (int) var HP_max

## needs to be a global value reference from player HP and constantly updated
var Health = 97

func _ready():
	# connect the pressed signal to the 
	owner.connect("Damage_Player", self, "_receive_damage")

func _process(delta):
	
	if Health < HP_min:
		hits = 0
	if Health >= HP_min and Health <= HP_max:
		hits = Health - HP_min
	animation = str(hits)
	


func _receive_damage(x):
	Health -= x
