extends Node

var current_scene = null

var MaxHealth = 8.0
onready var health = MaxHealth
var resource = 100

var cost_block = 10
var cost_red = 15
var cost_blue = 20
var cost_green = 30
var cost_yellow = 45
var cost_purple = 60

var dead = false

var Spawn_point

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)
	
func _process(delta):
	if health < 0:
		health = 0

func get_dead(s):
	dead = s

func get_player():
	current_scene.get_node("Queen").connect("dead", self, "get_dead")
	Spawn_point = current_scene.get_node("Spawn").position
