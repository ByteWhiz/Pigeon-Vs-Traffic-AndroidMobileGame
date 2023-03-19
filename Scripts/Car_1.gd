extends VehicleBody

signal CameraSHakeEffect
signal SlomoSignal
signal PoopHitCars

onready var car = $"."
var speed = 0.05
var direction = Vector3(0,0,speed)
var new_pos = self.transform.origin
var flag 


func _ready():
	self.connect("CameraSHakeEffect", get_node("/root/Level/Camera"), "ScreenSHakeEffectFunction")
	self.connect("SlomoSignal", get_node("/root/Level"), "DoubleHitCounter")
	self.connect('PoopHitCars', get_node("/root/Level/Player"), "ScoreUpdateCarHit")
	flag = true
	

func _physics_process(delta):
	# Move the bullet downwards
	if flag == true:
		new_pos.z -= 0.001
		self.transform.origin += new_pos
	








func _on_AreaCar_1_body_entered(body):
	if body.name == "Poop":
		emit_signal("PoopHitCars")
		#connncted to "Camera node" in Level scene! 
		emit_signal("CameraSHakeEffect")
		flag = false
		#make the car go bsKJBk!
		$".".apply_impulse(($".".global_transform.origin),Vector3(0,-10.05,-5))
		#make slow motion effect connected to "Level node"
		emit_signal("SlomoSignal")
		$Car_crash_sound.play(0.38)
	if body.name == "Police_1":
		$".".apply_impulse(($".".global_transform.origin),Vector3(0,-10.05,-5))
		
		


func _on_Live_timeout():
	queue_free()
