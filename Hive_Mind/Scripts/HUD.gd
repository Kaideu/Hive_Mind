extends Node

signal SpawnClone(type)
signal mouse_left

signal Damage_Player

var able_spawn = false

var blue
var red_
var green
var yellow
var purple
var block

onready var buttons = [$Top/ButtonBlock, $Top/ButtonRed, $Top/ButtonBlue, $Top/ButtonGreen, $Top/ButtonYellow, $Top/ButtonPurple]

onready var B = preload ("res://Scenes/Hive_Block.tscn")
onready var Pre_Block = B.instance()

func _ready():
	add_child(Pre_Block)
	Pre_Block.modulate.a = 0.3
	pass

func _process(delta):
	Pre_Block.visible = $Top/ButtonBlock.pressed
	var Mouse_Pos = get_viewport().get_mouse_position()
	var Tile_Pos = $TileMap.map_to_world($TileMap.world_to_map(get_viewport().get_mouse_position()))
	Pre_Block.position = Tile_Pos + Vector2(32,32)
	$Top/Label_Amount.text = str(Global.resource)

func button_able_toggle(pressed, type):
	for i in buttons:
		if i != buttons[type]:
			i.disabled = pressed

func _input(event):
	if event.is_action_pressed("Place_Piece"):
		emit_signal("mouse_left")

func _SpawnClone(type):
	#print("entered")
	emit_signal("SpawnClone", type)


func _on_ButtonBlock_toggled(pressed):
	button_able_toggle(pressed, 0)
	while pressed:
		yield(self, "mouse_left")
		if $Top/ButtonBlock.pressed == false:
			pressed = false
			button_able_toggle(pressed, 0)
			break
		if able_spawn and pressed:
			var able_buy = CheckResource(Global.cost_block)
			if able_buy:
				Global.resource -= Global.cost_block
				_SpawnClone("block")
			else:
				print("Not Enough Resource")


func _on_ButtonRed_toggled(pressed):
	button_able_toggle(pressed, 1)
	while pressed:
		yield(self, "mouse_left")
		if $Top/ButtonRed.pressed == false:
			pressed = false
			button_able_toggle(pressed, 1)
			break
		if able_spawn and pressed:
			var able_buy = CheckResource(Global.cost_red)
			if able_buy:
				Global.resource -= Global.cost_red
				_SpawnClone("red")
			else:
				print("Not Enough Resource")


func _on_ButtonBlue_toggled(pressed):
	button_able_toggle(pressed, 2)
	while pressed:
		yield(self, "mouse_left")
		if $Top/ButtonBlue.pressed == false:
			pressed = false
			button_able_toggle(pressed, 2)
			break
		if able_spawn and pressed:
			var able_buy = CheckResource(Global.cost_blue)
			if able_buy:
				Global.resource -= Global.cost_blue
				_SpawnClone("blue")
			else:
				print("Not Enough Resource")


func _on_ButtonGreen_toggled(pressed):
	button_able_toggle(pressed, 3)
	while pressed:
		yield(self, "mouse_left")
		if $Top/ButtonGreen.pressed == false:
			pressed = false
			button_able_toggle(pressed, 3)
			break
		if able_spawn and pressed:
			var able_buy = CheckResource(Global.cost_green)
			if able_buy:
				Global.resource -= Global.cost_green
				_SpawnClone("green")
			else:
				print("Not Enough Resource")


func _on_ButtonYellow_toggled(pressed):
	button_able_toggle(pressed, 4)
	while pressed:
		yield(self, "mouse_left")
		if $Top/ButtonYellow.pressed == false:
			pressed = false
			button_able_toggle(pressed, 4)
			break
		if able_spawn and pressed:
			var able_buy = CheckResource(Global.cost_yellow)
			if able_buy:
				Global.resource -= Global.cost_yellow
				_SpawnClone("yellow")
			else:
				print("Not Enough Resource")


func _on_ButtonPurple_toggled(pressed):
	button_able_toggle(pressed, 5)
	while pressed:
		yield(self, "mouse_left")
		if $Top/ButtonPurple.pressed == false:
			pressed = false
			button_able_toggle(pressed, 5)
			break
		if able_spawn and pressed:
			var able_buy = CheckResource(Global.cost_purple)
			if able_buy:
				Global.resource -= Global.cost_purple
				_SpawnClone("purple")
			else:
				print("Not Enough Resource")


func _on_HUD_mouse_entered():
	able_spawn = true
	#print("EnteredHUD")


func _on_HUD_mouse_exited():
	able_spawn = false
	#print("Left HUD")


func _on_Button_pressed():
	emit_signal("Damage_Player", 2)

func CheckResource(amount):
	if amount > Global.resource:
		return false
	elif amount <= Global.resource:
		return true