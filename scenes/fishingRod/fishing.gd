class_name Fishing
extends Node2D

@onready var bamboo_rod: BambooRod = %BambooRod
@onready var bobber: Bobber = %Bobber
@onready var fishing_line: Line2D = %FishingLine
@onready var ripple: Node2D = $Ripple

enum State {IDLE, CASTING, WAITING, BITE, FIGHT, CAUGHT, FAILED}

var state := State.IDLE
var waiting_time := 0.0 # Testing

func _ready() -> void:
	bobber.cast_complete.connect(onCastComplete.bind())

func _process(_delta: float) -> void:
	fishing_line.visible = isFishing()
	ripple.visible = state == State.BITE or state == State.FIGHT
	handle_input()
	handleFishingLine()
	
	if state == State.WAITING:
		waiting_time -= _delta
		if waiting_time <= 0:
			state = State.BITE
			StateManager.fish_bite.emit()

func handle_input() -> void:
	if Input.is_action_just_pressed("a") and state == State.IDLE:
		StateManager.cast_bobber.emit()
		state = State.CASTING

func handleFishingLine() -> void:
	var rod_point := fishing_line.to_local(bamboo_rod.line_point.global_position)
	var bobber_point := fishing_line.to_local(bobber.line_point.global_position)
	fishing_line.set_point_position(0, rod_point)
	fishing_line.set_point_position(1, bobber_point)

func isFishing() -> bool:
	return [State.WAITING, State.BITE, State.FIGHT, State.CASTING].has(state)

func onCastComplete() -> void:
	state = State.WAITING
	waiting_time = randf_range(2.0, 5.0)
