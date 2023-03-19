extends Control


var taps = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/VBoxContainer/Button.hide()
	
func _physics_process(delta):
	if !$Animation.is_playing():
		$Animation.play("DoubleTap")
	if Input.is_mouse_button_pressed(true):
		$Animation.play("DragLeftRight")
		$MarginContainer/Label.text = "Drag left & right to move!"
		$MarginContainer/VBoxContainer/Button.show()
		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	GameManager.first = true
	GameManager.save()
	queue_free()
