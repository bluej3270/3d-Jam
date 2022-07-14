extends Spatial
var timer

func reset():
	get_parent().reset(true)

func get_next_level_pos():
	return $next_level

func _on_remove_last_body_entered(body):
	pass # Replace with function body.

func _on_gen_next_body_entered(body):
	get_parent().generate_next()
	$gen_next.queue_free()

