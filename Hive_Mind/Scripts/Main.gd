extends Node

signal mouse_left

var Checking_Spawn = false
var able_spawn = false

onready var Clone = preload("res://Scenes/Clone.tscn")
var list_Clones = []
onready var GetPlayer = preload("res://Scenes/Queen.tscn")
onready var GetHUD = preload("res://Scenes/HUD.tscn")

func _ready():
	var Player = GetPlayer.instance()
	Player.position = $Spawn.position
	add_child(Player)
	add_child(GetHUD.instance())
	get_HUD()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _SpawnClone(type):
	print("entered")
	able_spawn = true
	Checking_Spawn = true
	var NewClone = Clone.instance()
	NewClone.unit_type = type
	if able_spawn:
		$Game.add_child(NewClone)
		NewClone.position = get_viewport().get_mouse_position()
		able_spawn = false
	print("NewClone Added")
	list_Clones.push_back(NewClone.get_name())
	print(list_Clones)

func _input(event):
	if event.is_action_pressed("Place_Piece"):
		emit_signal("mouse_left")

func get_HUD():
	$HUD.connect("SpawnClone", self, "_SpawnClone")