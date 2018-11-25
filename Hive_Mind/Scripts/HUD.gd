extends Node

signal Damage
signal SpawnClone(type)

var able_spawn = true

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _DamageCall():
	emit_signal("Damage")

func _SpawnClone(type):
	if able_spawn:
		emit_signal("SpawnClone", type)


func _on_Button1_pressed():
	_SpawnClone("block")


func _on_ButtonRed_pressed():
	_SpawnClone("red")


func _on_ButtonBlue_pressed():
	_SpawnClone("blue")


func _on_ButtonGreen_pressed():
	_SpawnClone("green")


func _on_ButtonYellow_pressed():
	_SpawnClone("yellow")


func _on_ButtonPurple_pressed():
	_SpawnClone("purple")
