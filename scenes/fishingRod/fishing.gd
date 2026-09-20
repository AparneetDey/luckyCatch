class_name Fishing
extends Node2D

@onready var bamboo_rod: BambooRod = %BambooRod
@onready var bobber: Bobber = %Bobber
@onready var fishing_line: Line2D = %FishingLine
@onready var ripple: Node2D = $Ripple

enum State {IDLE, CASTING, WAITING, BITE, FIGHT, CAUGHT, FAILED}

var catch_progress : float = 0.0
var current_fish : FishData = null
var danger_time : float = 0.0
var difficulty_time : float = 0.0
var reel_speed : float
var release_speed : float
var state := State.IDLE
var safe_zone_size : float = 0.0
var safe_zone_position : float = 0.0
var tension : float = 0.0
var waiting_time := 0.0 # Testing

func _ready() -> void:
	bobber.cast_complete.connect(onCastComplete.bind())
	StateManager.pop_up_close.connect(onPopUpClose.bind())
	on_idle()

func on_idle() -> void:
	if state == State.IDLE:
		StateManager.task_info.emit("A to Cast")

func _process(delta: float) -> void:
	fishing_line.visible = isFishing()
	ripple.visible = state == State.BITE
	handle_input(delta)
	handle_fishing_line()
	handle_catch_time(delta)
	handle_danger_time(delta)
	handle_difficulty(delta)
	
	if state == State.WAITING:
		waiting_time -= delta
		if waiting_time <= 0:
			state = State.BITE
			current_fish = FishManager.select_fish()
			reel_speed = current_fish.reel_speed
			release_speed = current_fish.release_speed
			safe_zone_size = current_fish.safe_zone_start_size
			safe_zone_position = randf_range(0.0, 1.0 - safe_zone_size)
			bobber.movement_radius_x = current_fish.movement_radius_x
			bobber.movement_radius_y = current_fish.movement_radius_y
			bobber.movement_speed = current_fish.movement_speed
			StateManager.update_safe_zone.emit(safe_zone_size, safe_zone_position)
			StateManager.fish_bite.emit()
			StateManager.task_info.emit("S to Reel")

func handle_input(delta: float) -> void:
	if state == State.IDLE and Input.is_action_just_pressed("a"):
		StateManager.cast_bobber.emit()
		StateManager.task_info.emit("")
		state = State.CASTING
	
	if state == State.BITE and Input.is_action_just_pressed("s"):
		state = State.FIGHT
		StateManager.reel_start.emit()
		StateManager.task_info.emit("Control the Reel")
	
	if state == State.FIGHT:
		if Input.is_action_pressed("s"):
			tension += reel_speed * delta
		else:
			tension -= release_speed * delta
		
		tension = clamp(tension, 0.0, 1.0)
		StateManager.update_reel_indicator.emit(tension)

func handle_difficulty(delta: float) -> void:
	if state == State.FIGHT:
		difficulty_time += delta
		
		if difficulty_time >= current_fish.difficulty_interval:
			difficulty_time -= current_fish.difficulty_interval
			increase_difficulty()

func increase_difficulty() -> void:
	safe_zone_size = max(safe_zone_size - 0.05, current_fish.safe_zone_min_size)
	
	safe_zone_position = randf_range(0.0, 1.0 - safe_zone_size)
	
	reel_speed = min(reel_speed + 0.5, current_fish.max_reel_speed)
	
	release_speed = min(release_speed + 0.3, current_fish.max_release_speed)
	
	StateManager.update_safe_zone.emit(safe_zone_size, safe_zone_position)

func handle_fishing_line() -> void:
	var rod_point := fishing_line.to_local(bamboo_rod.line_point.global_position)
	var bobber_point := fishing_line.to_local(bobber.line_point.global_position)
	fishing_line.set_point_position(0, rod_point)
	fishing_line.set_point_position(1, bobber_point)

func handle_danger_time(delta: float) -> void:
	if state == State.FIGHT:
		if isInsideSafeZone():
			danger_time = 0
		else:
			danger_time += delta
			
			if danger_time >= current_fish.danger_limit:
				StateManager.catch_failed.emit()
				StateManager.task_info.emit("V to Continue")
				state = State.FAILED
				danger_time = 0.0

func handle_catch_time(delta: float) -> void:
	if state == State.FIGHT:
		if isInsideSafeZone():
			catch_progress += delta
			
			if catch_progress >= current_fish.required_catch_time:
				StateManager.fish_caught.emit(current_fish)
				StateManager.task_info.emit("V to Continue")
				state = State.CAUGHT
				catch_progress = 0.0

func isFishing() -> bool:
	return [State.WAITING, State.BITE, State.FIGHT, State.CASTING].has(state)

func isInsideSafeZone() -> bool:
	return tension >= safe_zone_position and tension <= safe_zone_position + safe_zone_size

func onCastComplete() -> void:
	state = State.WAITING
	waiting_time = randf_range(2.0, 5.0)

func onPopUpClose() -> void:
	current_fish = null
	state = State.IDLE
	on_idle()
	StateManager.reel_stop.emit()
