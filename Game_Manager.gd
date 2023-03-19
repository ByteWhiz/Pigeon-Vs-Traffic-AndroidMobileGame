extends Node


var first
var BestScore 
var path = "user://savedata.dat"
func save():
	var data = {
		"Score" : BestScore,
		"first_time": first
	}
	var file = File.new()
	file.open(path,File.WRITE)
	file.store_var(data)
	file.close()
	
func loadScore():
	var file = File.new()
	if file.file_exists(path):
		file.open(path, File.READ )
		var player_data = file.get_var()
		file.close()
		return player_data["Score"]
		
func loadfirsttime():
	var file = File.new()
	if file.file_exists(path):
		file.open(path, File.READ )
		var player_data = file.get_var()
		file.close()
		return player_data["first_time"]
