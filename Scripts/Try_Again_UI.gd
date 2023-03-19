extends Control




func _ready():
	#$LabelBestScore.text = "Best Score: " + str(BestScoreValue)
	pass
	
func _physics_process(delta):
	var BestScoreValue = GameManager.loadScore()
	$MarginContainer/VBoxContainer/LabelBestScore.text = "Best Score: " + str(BestScoreValue)
	BestScoreValue = lerp(BestScoreValue, BestScoreValue , delta)

func _on_Exit_pressed():
	get_tree().quit()


func _on_TryAgainBtn_pressed():
	get_tree().reload_current_scene()

