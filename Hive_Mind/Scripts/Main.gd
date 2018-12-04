extends Node

signal mouse_left

var Checking_Spawn = false
var able_spawn = false

onready var Block = preload("res://Scenes/Hive_Block.tscn")
onready var Clone = preload("res://Scenes/Clone.tscn")
var list_Clones = []
onready var GetPlayer = preload("res://Scenes/Queen.tscn")
onready var GetHUD = preload("res://Scenes/HUD.tscn")

var current_blocks = []

func _ready():
	var Player = GetPlayer.instance()
	Player.position = $Spawn.position
	add_child(Player)
	add_child(GetHUD.instance())
	get_HUD()
	current_blocks.push_back($TileMap.map_to_world($TileMap.world_to_map($PoweSource.position)) + Vector2(32,32))
	print(current_blocks)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _SpawnClone(type):
	var Mouse_Pos = get_viewport().get_mouse_position()
	var Tile_Pos = $TileMap.map_to_world($TileMap.world_to_map(get_viewport().get_mouse_position()))
	able_spawn = true
	Checking_Spawn = true
	if type == "block":
		able_spawn = Check_Placement()
		var NewBlock = Block.instance()
		if able_spawn:
			$Game.add_child(NewBlock)
			NewBlock.position = Tile_Pos + Vector2(32,32) # Needs to be replaced with tile position
			#current_blocks.append(NewBlock.position)
			print(current_blocks)
			able_spawn = false
	else:
		var NewClone = Clone.instance()
		NewClone.unit_type = type
		if able_spawn:
			$Game.add_child(NewClone)
			NewClone.position = Mouse_Pos
			able_spawn = false

func _input(event):
	if event.is_action_pressed("Place_Piece"):
		emit_signal("mouse_left")

func get_HUD():
	$HUD.connect("SpawnClone", self, "_SpawnClone")

#May change this so that it doesn't lag as the array grows.
#May replace array with raycast or similar.
func Check_Placement():
	var Tile_Pos = $TileMap.map_to_world($TileMap.world_to_map(get_viewport().get_mouse_position())) + Vector2(32,32)
	var U = Vector2(0,-64)
	var D = Vector2(0,64)
	var L = Vector2(-64,0)
	var R = Vector2(64,0)
	if current_blocks.has(Tile_Pos):
			print("can't place")
			return false
	else:
		for i in current_blocks:
			print(i)
			print(Tile_Pos)
			if Tile_Pos == i + U or Tile_Pos == i + D or Tile_Pos == i + L or Tile_Pos == i + R:
				current_blocks.push_back(Tile_Pos)
				print("Placed up")
				return true
	print("Not Placed")
	return false