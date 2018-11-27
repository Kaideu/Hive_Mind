extends Node

signal Damage
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

func _ready():
	pass


func _process(delta):
	pass

func button_able_toggle(pressed, type):
	for i in buttons:
		if i != buttons[type]:
			i.disabled = pressed

func _input(event):
	if event.is_action_pressed("Place_Piece"):
		emit_signal("mouse_left")

func _DamageCall():
	emit_signal("Damage")

func _SpawnClone(type):
	print("entered")
	emit_signal("SpawnClone", type)


func _on_ButtonBlock_toggled(pressed):
	button_able_toggle(pressed, 0)
	while pressed:
		print(pressed)
		yield(self, "mouse_left")
		if $Top/ButtonBlock.pressed == false:
			pressed = false
			button_able_toggle(pressed, 0)
			break
		if able_spawn and pressed:
			_SpawnClone("block")


func _on_ButtonRed_toggled(pressed):
	button_able_toggle(pressed, 1)
	while pressed:
		yield(self, "mouse_left")
		if $Top/ButtonRed.pressed == false:
			pressed = false
			button_able_toggle(pressed, 1)
			break
		if able_spawn and pressed:
			_SpawnClone("red")


func _on_ButtonBlue_toggled(pressed):
	button_able_toggle(pressed, 2)
	while pressed:
		yield(self, "mouse_left")
		if $Top/ButtonBlue.pressed == false:
			pressed = false
			button_able_toggle(pressed, 2)
			break
		if able_spawn and pressed:
			_SpawnClone("blue")


func _on_ButtonGreen_toggled(pressed):
	button_able_toggle(pressed, 3)
	while pressed:
		yield(self, "mouse_left")
		if $Top/ButtonGreen.pressed == false:
			pressed = false
			button_able_toggle(pressed, 3)
			break
		if able_spawn and pressed:
			_SpawnClone("green")


func _on_ButtonYellow_toggled(pressed):
	button_able_toggle(pressed, 4)
	while pressed:
		yield(self, "mouse_left")
		if $Top/ButtonYellow.pressed == false:
			pressed = false
			button_able_toggle(pressed, 4)
			break
		if able_spawn and pressed:
			_SpawnClone("yellow")


func _on_ButtonPurple_toggled(pressed):
	button_able_toggle(pressed, 5)
	while pressed:
		yield(self, "mouse_left")
		if $Top/ButtonPurple.pressed == false:
			pressed = false
			button_able_toggle(pressed, 5)
			break
		if able_spawn and pressed:
			_SpawnClone("purple")


func _on_HUD_mouse_entered():
	able_spawn = true
	print("EnteredHUD")


func _on_HUD_mouse_exited():
	able_spawn = false
	print("Left HUD")


func _on_Button_pressed():
	emit_signal("Damage_Player", 2)
