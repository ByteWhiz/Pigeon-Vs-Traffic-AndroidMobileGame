extends VehicleBody


signal CameraSHakeEffect2
signal SlomoSignal2
signal PoopHitCars
signal PoopHitPolice

var flag
var speed = 0.05
var direction = Vector3(0,0,speed)
var new_pos = self.transform.origin
func _ready():
	flag = true
	self.connect('PoopHitCars', get_node("/root/Level/Player"), "ScoreUpdateCarHit")
	self.connect("CameraSHakeEffect2", get_node("/root/Level/Camera"), "ScreenSHakeEffectFunction")
	self.connect("SlomoSignal2", get_node("/root/Level"), "DoubleHitCounter")

func _physics_process(delta):
	# Move the bullet downwards
	if flag == true:
		new_pos.z += 0.001
		self.transform.origin += new_pos
	




func _on_Area_Car_2_body_entered(body):
		if body.name == "Poop":
			#connncted to "Camera node" in Level scene! 
			emit_signal("PoopHitCars")
			emit_signal("CameraSHakeEffect2")
			flag = false
			#make the car go bsKJBk!
			$".".apply_impulse(($".".global_transform.origin),Vector3(0,-10.05, 5))
			#make slow motion effect connected to "Level node"
			emit_signal("SlomoSignal2")
			$Car_crash_sound.play(0.41)


func _on_Live_timeout():
	queue_free()
