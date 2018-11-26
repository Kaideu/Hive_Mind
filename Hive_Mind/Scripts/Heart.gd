extends AnimatedSprite

var hits = 8

export (int) var HP_range

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	
	animation = str(hits)
