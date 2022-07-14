extends Spatial

var levels = 13
var next_level_pos = Vector3(0, 0, 0)

var rng = RandomNumberGenerator.new()
 
func _ready():
	rng.randomize()
	generate_next()

func reset(death):
	var score = $Player.get_score()
	var time = $Player.get_time()
	get_tree().reload_current_scene()
	if death:
		$Player.show_death_screen(time, score)

func generate_next():
	var l = rng.randi_range(1, levels)
	var level = load("res://Levels/" + str(l) + '.tscn')
	level = level.instance()
	level.global_transform.origin = next_level_pos
	self.add_child(level)
	next_level_pos = level.get_next_level_pos().global_transform.origin
	$Player.add_point()
