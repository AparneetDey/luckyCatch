class_name River
extends Node2D

const RIPPLE_PREFAB = preload("res://scenes/vfx/ripple.tscn")

@onready var ripple_spots: Node2D = %RippleSpots

@export var max_ripple_delay : float
@export var min_ripple_delay : float

var duration_between_ripple : float = 0.0
var time_since_last_ripple : float = Time.get_ticks_msec()

func _ready() -> void:
	duration_between_ripple = randf_range(min_ripple_delay, max_ripple_delay)
	time_since_last_ripple = Time.get_ticks_msec()

func _process(_delta: float) -> void:
	spawn_ripple()

func spawn_ripple() -> void:
	if(Time.get_ticks_msec() - time_since_last_ripple > duration_between_ripple):
		var ripple : Node2D = RIPPLE_PREFAB.instantiate()
		var ind : int = randi_range(0, ripple_spots.get_child_count() - 1)
		var ripple_spot : Node2D = ripple_spots.get_child(ind)
		
		ripple.global_position = ripple_spot.global_position
		call_deferred("add_child", ripple)
		duration_between_ripple = randf_range(min_ripple_delay, max_ripple_delay)
		time_since_last_ripple = Time.get_ticks_msec()
