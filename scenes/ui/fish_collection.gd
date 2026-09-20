class_name FishCollection
extends Control

@onready var scroll_container: ScrollContainer = %ScrollContainer

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		scroll_container.scroll_vertical -= 20
	elif event.is_action_pressed("down"):
		scroll_container.scroll_vertical += 20
