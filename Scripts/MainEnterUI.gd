extends Spatial


onready var car = $"hilx97"
onready var Police_car = $Police
onready var camera_animation = $Camera/AnimationCamera

func _ready():
	#keep playing the camera animation
	camera_animation.play("animaton")

func _physics_process(delta):
	#rotating the models 
	rotate_models()

func _on_Button_pressed():
	#on start button pressed scene is changed into "LEVEL SCENE"
	get_tree().change_scene("res://Scenes/Level.tscn")


func _on_exitbtn_pressed():
	get_tree().quit()
	
func rotate_models():
	Police_car.rotate_x(0.005)
	car.rotate_y(0.005)
	car.rotate_z(0.005)
	car.rotate_x(0.005)
