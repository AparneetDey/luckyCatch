extends Node2D

@export var one_time : bool = true

func onAnimationComplete() -> void:
	if one_time:
		queue_free()
