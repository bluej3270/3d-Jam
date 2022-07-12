extends Spatial
var timer

func reset():
	get_parent().reset()

func get_next_level_pos():
	return $next_level


func _on_remove_last_body_entered(body):
	pass # Replace with function body.


func _on_gen_next_body_entered(body):
	if not timer:
		timer = true
		$Timer.start()
		get_parent().generate_next()
		$gen_next.queue_free()

func _on_Timer_timeout():
	timer = true
