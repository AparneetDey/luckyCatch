class_name BambooRod
extends Node2D

@export var max_shift_from_center : int
@export var pull_speed : float
@export var return_speed : float

@onready var animation_player: AnimationPlayer = %AnimationPlayer

enum State {IDLE, PULL_LEFT, PULL_RIGHT}

var initial_position : Vector2 = Vector2.ZERO
var state : State = State.IDLE

func _ready() -> void:
	initial_position = position

func _process(delta: float) -> void:
	handle_animation()
	handle_state()
	handle_input(delta)

func handle_animation() -> void:
	if state == State.IDLE:
		animation_player.play("idle")
	elif state == State.PULL_LEFT:
		animation_player.play("pull_left")
	elif state == State.PULL_RIGHT:
		animation_player.play("pull_right")

func handle_state() -> void:
	if(position == initial_position):
		state = State.IDLE
	elif(position.x > initial_position.x):
		state = State.PULL_RIGHT
	elif(position.x < initial_position.x):
		state = State.PULL_LEFT

func handle_input(delta: float) -> void:
	var input_dir := Input.get_axis("left", "right")
	
	if(input_dir == 0):
		position.x = move_toward(position.x, initial_position.x, return_speed*delta)
	else:
		var target_x := initial_position.x + max_shift_from_center * input_dir
		
		position.x = move_toward(position.x, target_x, pull_speed * delta)
	
	
