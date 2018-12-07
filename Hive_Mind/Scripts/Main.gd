extends Node

signal mouse_left

var Checking_Spawn = false
var able_spawn = false

onready var Block = preload("res://Scenes/Hive_Block.tscn")
onready var Clone = preload("res://Scenes/Clone.tscn")
var list_Clones = []
onready var GetPlayer = preload("res://Scenes/Queen.tscn")
onready var GetHUD = preload("res://Scenes/HUD.tscn")

var Mouse_Pos
var Tile_Pos

var HiveCircuit = 0

var test

#var current_blocks = []

func _ready():
	var Player = GetPlayer.instance()
	Player.position = $Spawn.position
	add_child(Player)
	add_child(GetHUD.instance())
	get_HUD()

func _process(delta):
	Mouse_Pos = get_viewport().get_mouse_position()
	Tile_Pos = $TileMap.map_to_world($TileMap.world_to_map(Mouse_Pos)) + Vector2(32,32)
	

func _SpawnClone(type):
	if type == "block":
		able_spawn = Check_Placement2()
		if able_spawn:
			able_spawn = CheckResource(Global.cost_block)
			if able_spawn:
				Global.resource -= Global.cost_block
				var NewBlock = Block.instance()
				if HiveCircuit > 0:
					NewBlock.C_Num = HiveCircuit # Assigns circuit number as 1 if next to powersource
					NewBlock.InCircuit = true
				$Game.add_child(NewBlock)
				NewBlock.position = Tile_Pos
				able_spawn = false
				HiveCircuit = 0
	else:
		able_spawn = true
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

func Check_Placement2():
	var C = false
	$RayCast2D.position = Tile_Pos
	var Up = Vector2(0, -64)
	var Down = Vector2(0, 64)
	var Left = Vector2(-64, 0)
	var Right = Vector2(64, 0)
	var Same = Vector2(0,0)
	var Dir = [Same, Up, Down, Left, Right]
	for i in Dir:
		$RayCast2D.cast_to = i
		$RayCast2D.force_raycast_update()
		if $RayCast2D.is_colliding():
			if i == Same:
				return false
			else:
				test = $RayCast2D.get_collider()
				if test.name == "PowerSource":
					HiveCircuit = 1
					print(HiveCircuit)
				C = true
	$RayCast2D.enabled = false
	return C
	
	
	return false

func CheckResource(amount):
	if amount > Global.resource:
		return false
	elif amount <= Global.resource:
		return true