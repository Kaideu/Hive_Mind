extends Node

signal Damage
signal SpawnClone(type)
signal mouse_left

var able_spawn = false

func _ready():
	pass



func _process(delta):
	pass



func _input(event):
	if event.is_action_pressed("Place_Piece"):
		emit_signal("mouse_left")

func _DamageCall():
	emit_signal("Damage")

func _SpawnClone(type):
	print("entered")
	emit_signal("SpawnClone", type)


func _on_ButtonBlock_toggled():
	yield(self, "mouse_left")
	if able_spawn:
		_SpawnClone("block")


func _on_ButtonRed_toggled(pressed):
	if pressed:
		yield(self, "mouse_left")
		print(pressed)
		if able_spawn and pressed:
			_SpawnClone("red")


func _on_ButtonBlue_toggled():
	yield(self, "mouse_left")
	if able_spawn:
		_SpawnClone("blue")


func _on_ButtonGreen_toggled():
	yield(self, "mouse_left")
	if able_spawn:
		_SpawnClone("green")


func _on_ButtonYellow_toggled():
	yield(self, "mouse_left")
	if able_spawn:
		_SpawnClone("yellow")


func _on_ButtonPurple_toggled():
	yield(self, "mouse_left")
	if able_spawn:
		_SpawnClone("purple")


func _on_HUD_mouse_entered():
	able_spawn = true
	print("EnteredHUD")


func _on_HUD_mouse_exited():
	able_spawn = false
	print("Left HUD")
