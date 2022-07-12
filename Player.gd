extends KinematicBody

onready var camera = $Pivot/Camera

var gravity = -30
var max_speed = 8
var mouse_sensitivity = 0.002  # radians/pixel

var velocity = Vector3()

var red = true
var invince = false

var time_from_on_floor : float
var coyote_time = 0.25

func get_input():
	var input_dir = Vector3()
	# desired move in camera direction
	if Input.is_action_pressed("move_forward"):
		input_dir += -global_transform.basis.z
	if Input.is_action_pressed("move_back"):
		input_dir += global_transform.basis.z
	if Input.is_action_pressed("strafe_left"):
		input_dir += -global_transform.basis.x
	if Input.is_action_pressed("strafe_right"):
		input_dir += global_transform.basis.x
	input_dir = input_dir.normalized()
	return input_dir

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -1.2, 1.2)

func _physics_process(delta):
	if self.is_on_floor():
		time_from_on_floor = 0
	else: 
		time_from_on_floor += 1*delta
	
	velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed
	
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	
	if Input.is_action_just_pressed("jump"):
		if time_from_on_floor <= coyote_time:
			velocity.y = 15
		else:
			print(time_from_on_floor)
	velocity = move_and_slide(velocity, Vector3.UP, true)
	
	for i in range(0, get_slide_count()-1):
		var col = self.get_slide_collision(i)
		if col.collider.is_in_group('red'):
			if red:
				pass
			else:
				get_parent().reset()
				print('Died to touching Red')
		elif col.collider.is_in_group('blue'):
			if !red:
				pass
			else:
				get_parent().reset()
				print('Died to touching Blue')
		if col.collider.is_in_group('change_red'):
			set_red()
			
		elif col.collider.is_in_group('change_blue'):
			set_blue()


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func set_red():
	red = true
	invince = true

func set_blue():
	red = false
	invince = true
	

func is_red():
	return red

func is_blue():
	return !red

func reset():
	get_parent().reset()

func _on_Timer_timeout():
	invince = false

func _process(delta):
	if red:
		pass
	else:
		pass
