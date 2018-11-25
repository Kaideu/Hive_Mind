extends Node

signal mouse_left
var Checking_Spawn = false
var able_spawn = false
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var Clone = preload("res://Scenes/Clone.tscn")
var list_Clones = []


func _ready():
	$HUD.connect("Damage", self, "_DamageClone")
	$HUD.connect("SpawnClone", self, "_SpawnClone")
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _DamageClone():
	pass

func _SpawnClone(type):
	able_spawn = true
	Checking_Spawn = true
	var NewClone = Clone.instance()
	NewClone.unit_type = type
	while(Checking_Spawn):
		yield (self, "mouse_left")
		Checking_Spawn = _Check_Mouse_Position()
	if able_spawn:
		add_child(NewClone)
		NewClone.position = get_viewport().get_mouse_position()
		able_spawn = false
	list_Clones.push_back(NewClone.get_name())
	print(list_Clones)

func _input(event):
	if event.is_action_pressed("Place_Piece"):
		emit_signal("mouse_left")

func _Check_Mouse_Position():
	return false