extends RigidBody

signal PoopHitCars
signal PoopHitPolice

var speed = 14
var direction = Vector3.DOWN

func _ready():
	pass

func _physics_process(delta):
	# Move the bullet downwards
	translate(direction * speed * delta)

	# Destroy the bullet if it goes below the screen
	if global_transform.origin.y < -7:
		queue_free()




func _on_AreaPoop_body_entered(body):
	if body.name == "Car_1" || body.name == "Car_2":
		emit_signal("PoopHitCars")
	

	if body.name == "Police_1":
		emit_signal("PoopHitPolice")
		




