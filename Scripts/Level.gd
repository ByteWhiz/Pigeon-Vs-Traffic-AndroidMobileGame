extends Spatial



var DisplayTimer
var DisplayScore 


var rng = RandomNumberGenerator.new()
var rng2 = RandomNumberGenerator.new()
var my_random_number2
var my_random_number

onready var ScoreLabel = $UiCanvas/Control/MarginContainer/VBoxContainer/ScoreDidplayLabel
onready var TimerLabel = $UiCanvas/Control/MarginContainer/VBoxContainer/TimeDisplayLabel
onready var Level = $"."
onready var DoubleCounterTimer = $Dubleconter
onready var progresbar = $UiCanvas/Control/MarginContainer/VBoxContainer/Label/ProgressBar
var provalue
var carCountSlomo = 0

onready var Slow_Motion_Timer = $SlomMoTimer
onready var F_Ui = $UiCanvas
onready var Finish_cam_animation = $Camera/cameraAnimations


func _ready():
	pass
	
	
func _physics_process(delta):
	progresbar.value = 100
	var random = RandomNumberGenerator.new()
	random.randomize()

	$Timer.wait_time = random.randi() % 5
	$Timer2.wait_time = random.randi() % 5
	$PoliceTimer.wait_time = random.randi() % 10
		
	ScoreLabel
	TimerLabel 
	rng = randomize()
	rng2 = randomize()
	UpdateTimer(DisplayTimer)
	TimerLabel.text = "Time left:" + str(DisplayTimer) 
	ScoreLabel.text = "Score:" + str(DisplayScore)
	if DisplayScore == null:
		DisplayScore = "0"
		ScoreLabel.text = str(DisplayScore)
	
func _on_Timer_timeout():
	var car_1 = preload("res://Scenes/Car_1.tscn").instance()
	var position = Vector3(1.2, 0.5, 5)
	car_1.transform.origin = position
	Level.add_child(car_1)
	car_1.set_as_toplevel(true)



func _on_Timer2_timeout():
	var car2 = preload("res://Scenes/Car_2.tscn").instance()
	var pos = Vector3(-1.4,0.5,-20)
	car2.transform.origin = pos
	Level.add_child(car2)
	var car_2_id = car2.get_instance_id()
	


func SlowMotionEffect():
	Slow_Motion_Timer.start(0.09)
	Engine.time_scale = 0.08

func _on_SlomMoTimer_timeout():
	Engine.time_scale = 1


#PASSD THE PARAMETER FROM PLAYER Scene
func DisplayScoreUpdate(score):
	DisplayScore = score
#passd the parameter from player scene
func UpdateTimer(TimeLeft):
	DisplayTimer = TimeLeft


func _on_PoliceTimer_timeout():
	var scene_instance = preload("res://Scenes/Police_1.tscn")
	var Police_1 = scene_instance.instance()
	var position = Vector3(1.2, 0.5, 10)
	Police_1.transform.origin = position
	Level.add_child(Police_1)
	
	
func DoubleHitCounter():
	carCountSlomo += 1
	if carCountSlomo == 1:
		DoubleCounterTimer.start(1.5)
	if carCountSlomo >= 2 && DoubleCounterTimer.wait_time > 0:
		SlowMotionEffect()

	
func DoubleHitTimeOut():
	carCountSlomo = 0

func LoadTryAgainUi():
	var tryAgainUI = preload("res://Scenes/Try_Again_UI.tscn").instance()
	F_Ui.add_child(tryAgainUI)
	tryAgainUI.set_as_toplevel(true)
	Finish_cam_animation.play("endAnimation")
	
func progresvalue(newvalue):
	progresbar.value = newvalue

