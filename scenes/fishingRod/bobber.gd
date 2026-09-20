class_name Bobber
extends Node2D

const RIPPLE_PREFAB = preload("res://scenes/vfx/ripple.tscn")

signal cast_complete

@onready var ripple_timer: Timer = $RippleTimer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var line_point: Marker2D = $LinePoint

enum State {IDLE, CASTING, BITE, CAUGHT, UNCAST}

var initial_position : Vector2 = Vector2.ZERO
var fight_time : float = 0.0
var fighting : bool = false
var movement_radius_x : float = 12.0
var movement_radius_y : float = 6.0
var movement_speed : float = 4.0
var state = State.UNCAST

func _ready() -> void:
	initial_position = global_position
	StateManager.cast_bobber.connect(onBobberCast.bind())
	StateManager.fish_bite.connect(onFishBite.bind())
	StateManager.reel_start.connect(onFightStart.bind())
	StateManager.fish_caught.connect(onFightStop.bind())

func _process(delta: float) -> void:
	handle_animation()
	handle_fighting(delta)

func handle_fighting(delta: float) -> void:
	if not fighting:
		return
	
	fight_time += delta
	var offset := Vector2(
		cos(fight_time * movement_speed) * movement_radius_x,
		sin(fight_time * movement_speed) * movement_radius_y
	)
	
	global_position = initial_position + offset

func handle_animation() -> void:
	if state == State.IDLE:
		animation_player.play("idle")
	elif state == State.CASTING:
		animation_player.play("cast")
	elif state == State.BITE:
		animation_player.play("bite")
	elif state == State.CAUGHT:
		animation_player.play("catch")
	elif state == State.UNCAST:
		animation_player.play("uncast")

func onBobberCast() -> void:
	state = State.CASTING
	visible = true

func onFishBite() -> void:
	state = State.BITE
	SoundPlayer.play(SoundManager.Sound.SPLASH)
	visible = false

func onFightStart() -> void:
	fighting = true
	fight_time = 0.0
	ripple_timer.start()

func onFightStop(_fish: FishData) -> void:
	fighting = false
	ripple_timer.stop()

func casting_complete() -> void:
	cast_complete.emit()
	state = State.IDLE

func biting_complete() -> void:
	state = State.CAUGHT

func _on_timer_timeout() -> void:
	StateManager.spawn_bobber_ripple.emit(global_position)
