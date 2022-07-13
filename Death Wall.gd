extends Area
export var speed = 0.5

func _on_Area_body_entered(body):
	if body.is_in_group('player'):
		body.zone_entered()


func _on_Area_body_exited(body):
	if body.is_in_group('player'):
		body.zone_exited()

func _physics_process(delta):
	self.translation.z -= speed
