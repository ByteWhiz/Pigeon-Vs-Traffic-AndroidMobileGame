extends Camera


var player 
export var follow_distance = Vector3(0,4,-10)
export var follow_lerp = 0.2
export var follow_offset = Vector2(0, 5.5)




func _ready():
	player = $"../Player"
	
func _physics_process(delta):
	var player_pos = player.global_transform.origin
	var target_pos = Vector3(player_pos.x + follow_offset.x, follow_distance.y, player_pos.z + follow_offset.y)
	var pos = self.global_transform.origin
	pos = pos.linear_interpolate(target_pos, follow_lerp)
	self.global_transform.origin = pos
	self.look_at(player_pos,Vector3(0, 0.001, 0))
#function conncted to Car_1 scene signal!
func ScreenSHakeEffectFunction():
	shake(2.0,0.9)
	
func shake(duration: float, amplitude: float):
	var original_pos = self.global_transform.origin
	var end_time = OS.get_ticks_msec() + duration * 1000 * 20

	while OS.get_ticks_msec() < end_time:
		var new_pos = original_pos + Vector3(rand_range(-amplitude, amplitude), rand_range(-amplitude, amplitude), 0)
		self.global_transform.origin = lerp(self.global_transform.origin, new_pos, 0.2)
		yield()

	self.global_transform.origin = original_pos

