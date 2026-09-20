class_name MainScreen
extends Control

@onready var button_animation: AnimationPlayer = $ButtonAnimation

var loading_complete : bool = false

func _process(_delta: float) -> void:
	if loading_complete and Input.is_action_just_pressed("a"):
		get_tree().change_scene_to_file("res://scenes/world/world.tscn")

func on_load_complete() -> void:
	button_animation.play("idle")
	loading_complete = true
