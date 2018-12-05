extends RigidBody2D

var InCircuit = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func _physics_process(delta):
	#print(get_colliding_bodies())
	pass


func _on_Hive_Block_body_entered(body):
	#print("Collided")
	pass
