extends Area

func _on_Death_Floor_body_entered(body):
	if body.is_in_group('player'):
		get_parent().reset()
