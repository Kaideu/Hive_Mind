extends RigidBody2D

var InCircuit = false
var C_Num = 0
var testNum = []

func _ready():
	pass


#func _physics_process(delta):
#	pass


func _on_Hive_Block_body_entered(body):
	var POS = position - body.position
	var X = abs(POS.x)
	var Y = abs(POS.y)
	var read = true
	if X > 1 and Y > 1:
		read = false
	#print(str(X) + " " + str(Y))
	#print("   " + str(read) + " on " + body.name)
	if body.has_method("_Circuit") and !InCircuit and read and body.name != "PowerSource":
		C_Num = body.C_Num + 1
		if !testNum.has(body.C_Num):
			#print("     Grabbing " + body.name + " " + str(body.C_Num))
			testNum.push_back(body.C_Num)
			testNum.sort()
			C_Num = testNum[0] + 1
			#print("    " + name + " is " + str(C_Num))
			InCircuit = true
	if body.has_method("_Circuit") and InCircuit and read:
		if !testNum.has(body.C_Num) and body.C_Num < C_Num:
			print("     Grabbing " + body.name + " " + str(body.C_Num))
			testNum.push_back(body.C_Num)
			testNum.sort()
			#print("    " + name + " " + str(testNum))
		if testNum.size() > 0:
			if testNum[0] < C_Num:
				C_Num = testNum[0] + 1
				print("    " + name + " is now " + str(C_Num))
#	if body.has_method("_Circuit"):
#		while body.get_node("Anim").current_animation_position != 0:
#			pass
#		print(0)
#	$Timer.wait_time = 1 # Need math expression for lining up animation times
#	$Timer.start()
	#print("    " + name + " " + str(testNum))

func _Circuit():
	pass

func _on_Timer_timeout():
	$Anim.play("idle")
