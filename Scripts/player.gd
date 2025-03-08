extends CharacterBody3D


var move_speed: float = 4.0
var jump_force: float = 8.0
var gravity: float = 20.0
var rotation_speed: float = 0.5

var facing_angle: float

@onready var model: MeshInstance3D = get_node("Model")

#### private vars ####
var _input

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_force

	_input = Input.get_vector(
		"move_left",
		"move_right",
		"move_forward",
		"move_backward"
	)
	var dir = Vector3(
		_input.x,
		0,
		_input.y
	)

	velocity.x = dir.x * move_speed
	velocity.z = dir.z * move_speed

	move_and_slide()

	_model_facing_angle()

	if global_position.y < -5:
		game_over()


func game_over() -> void:
	get_tree().call_deferred("reload_current_scene")


#### private ####

func _model_facing_angle() -> void:
	if _input.length() > 0:
		facing_angle = Vector2(_input.y, _input.x).angle()

	model.rotation.y = lerp_angle( \
		model.rotation.y, facing_angle, rotation_speed)
