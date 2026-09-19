class_name Bobber
extends Node2D

signal cast_complete

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var line_point: Marker2D = $LinePoint

enum State {IDLE, CASTING, CAUGHT, UNCAST}

var state = State.UNCAST

func _ready() -> void:
	StateManager.cast_bobber.connect(onBobberCast.bind())
	StateManager.fish_caught.connect(onFishCaught.bind())

func _process(_delta: float) -> void:
	handle_animation()

func handle_animation() -> void:
	if state == State.IDLE:
		animation_player.play("idle")
	elif state == State.CASTING:
		animation_player.play("cast")
	elif state == State.CAUGHT:
		animation_player.play("catch")
	elif state == State.UNCAST:
		animation_player.play("uncast")

func onBobberCast() -> void:
	print("Casting")
	state = State.CASTING
	visible = true

func onFishCaught() -> void:
	state = State.CAUGHT
	visible = false

func casting_complete() -> void:
	cast_complete.emit()
	print("animation casting")
	state = State.IDLE
