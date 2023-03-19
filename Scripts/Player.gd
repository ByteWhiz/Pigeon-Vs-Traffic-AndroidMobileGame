extends KinematicBody

signal SendScoretoUi
signal sendTimertoUI
signal endgame
signal progresvalue

var speed = 5
var max_left = -1.6
var max_right = 2.0
var can_shoot = true
var shoot_cooldown = 1
var shoot_timer = Timer.new()


var score = 0
var GameTimer = 60
var TimeLeft
var RoundTimeLeft
onready var TimerCountBack = $TimerConutBack
var Global_X_tuch
var GlobalStopMove

const DOUBLE_TAP_TIME = 0.3
var last_tap_time = 0.0
var Double_tap_bool
var bullet
var spacoalbullet
var progressFlag = false

func _ready():
	self.connect("endgame", get_node("/root/Level"),"LoadTryAgainUi")
	shoot_timer.connect("timeout", self, "_on_ShootTimer_timeout")
	add_child(shoot_timer)
	$TimerConutBack.start(GameTimer)
	self.connect("sendTimertoUI",get_node('/root/Level'), "UpdateTimer")
	self.connect("SendScoretoUi", get_node('/root/Level'),"DisplayScoreUpdate")
	self.connect("progresvalue", get_node('/root/Level'), "progresvalue")
	GlobalStopMove = false
	Double_tap_bool = false
	if GameManager.loadfirsttime() == null:
		var scene = preload("res://Scenes/FirstLoadTutorial.tscn").instance()
		$".".add_child(scene)
		scene.set_as_toplevel(true)
		
func _physics_process(delta):
	if progressFlag == true:
		progresbarupdate()
	TimeLeft = TimerCountBack.time_left
	RoundTimeLeft = round(TimeLeft)
	TimerUpdate()
	# Get the current position of the KinematicBody
	var pos = self.transform.origin
	
	if Global_X_tuch != null:
		var Screen = get_viewport().size
		if Global_X_tuch < (Screen.x / 2) && GlobalStopMove == false:
			pos.x -= speed * delta
			pos.x = max(pos.x, max_left)
		if Global_X_tuch > (Screen.x / 2) && GlobalStopMove == false:
			pos.x += speed * delta
			pos.x = min(pos.x, max_right)
		if GlobalStopMove == true:
			self.transform.origin = pos
		pos.x = clamp(pos.x,-2,pos.x)
		
	if can_shoot && Double_tap_bool == true:
			bullet = load("res://Scenes/Poop.tscn").instance()
			bullet.global_transform.origin = global_transform.origin + Vector3(0, 0, 0)
			spacoalbullet = bullet.get_instance_id()
			get_parent().add_child(bullet)
			progressFlag = true
			can_shoot = false
			shoot_timer.start(shoot_cooldown)
	Double_tap_bool = false
	self.transform.origin = pos

func _input(event):
	if event is InputEventScreenDrag:
		var X_TUCH = event.position.x
		Global_X_tuch = X_TUCH
		GlobalStopMove = false
	if event is InputEventScreenTouch and !event.pressed:
		print("stop")
		GlobalStopMove = true
	if event is InputEventScreenTouch and event.pressed:
		var current_time = OS.get_ticks_msec() / 1000.0
		var time_since_last_tap = current_time - last_tap_time
		if time_since_last_tap < DOUBLE_TAP_TIME:
			Double_tap_bool = true
		else:
			last_tap_time = current_time
		
func _on_ShootTimer_timeout():
	can_shoot = true
	progressFlag = false
	#Add click sound

func ScoreUpdatePoliceHit():
	score = score + 200
	emit_signal("SendScoretoUi", score)
	print("police_car hit")
func ScoreUpdateCarHit():
	score = score + 100
	emit_signal("SendScoretoUi",score)
	print("points")
	
func TimerUpdate():
	emit_signal("sendTimertoUI", RoundTimeLeft)


func _on_TimerConutBack_timeout():
	if GameManager.loadScore() == null:
		GameManager.BestScore = score
		GameManager.save()
	if score >= GameManager.loadScore():
		GameManager.BestScore = score
		GameManager.save()
	set_physics_process(false)
	emit_signal("endgame")

func progresbarupdate():
	emit_signal("progresvalue" , shoot_timer.time_left)
	
