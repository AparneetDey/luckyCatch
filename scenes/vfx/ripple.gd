class_name Ripple
extends Node2D

@export var one_time : bool = true

func _ready() -> void:
	SoundPlayer.play(SoundManager.Sound.RIPPLE, true)

func onAnimationComplete() -> void:
	if one_time:
		queue_free()
