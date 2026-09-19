class_name Bobber
extends Node2D

signal cast_complete

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var line_point: Marker2D = $LinePoint

enum State {IDLE, CASTING, BITE, CAUGHT, UNCAST}

var state = State.UNCAST

func _ready() -> void:
	StateManager.cast_bobber.connect(onBobberCast.bind())
	StateManager.fish_bite.connect(onFishBite.bind())

func _process(_delta: float) -> void:
	handle_animation()

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
	visible = false

func casting_complete() -> void:
	cast_complete.emit()
	state = State.IDLE

func biting_complete() -> void:
	state = State.CAUGHT
