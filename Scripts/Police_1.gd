extends VehicleBody


signal CameraSHakeEffectPolice1
signal SlomoSignalPolice1
signal PoopHitPolice


onready var car = $"."
var speed = 0.05
var direction = Vector3(0,0,speed)
var new_pos = self.transform.origin
var flag 


func _ready():
	self.connect("SlomoSignalPolice1", get_node("/root/Level"), "DoubleHitCounter")
	self.connect("CameraSHakeEffectPolice1", get_node("/root/Level/Camera"), "ScreenSHakeEffectFunction")
	self.connect('PoopHitPolice', get_node("/root/Level/Player"),'ScoreUpdatePoliceHit')
	$Live.start(4.5)
	flag = true
	$siren_sound.play()
	

# warning-ignore:unused_argument
func _physics_process(delta):
	# Move the bullet downwards
	if flag == true:
		new_pos.z -= 0.001
		self.transform.origin += new_pos
	



func _on_Live_timeout():
	queue_free()








func _on_AreaPolice_1_body_entered(body):
	if body.name == "Poop":
		#connncted to "Camera node" in Level scene! 
		emit_signal("PoopHitPolice")
		emit_signal("CameraSHakeEffectPolice1")
		flag = false
		#make the car go bsKJBk!
		$".".apply_impulse(($".".global_transform.origin),Vector3(0,-10.05,-5))
		#make slow motion effect connected to "Level node"
		emit_signal("SlomoSignalPolice1")
		$siren_sound.stop()
		$police_soundcrash.play(0.38)
		$after_crash.play(0.36)
		$after_crash.pitch_scale = 0.7
	if body.name == "Car_1":
		speed = 2
		$".".apply_impulse(($".".global_transform.origin),Vector3(0,-10.05,-5))
