extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$HUD.connect("Damage", self, "_DamageClone")
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _DamageClone():
	if $Clone != null:
		$Clone.Damaged()