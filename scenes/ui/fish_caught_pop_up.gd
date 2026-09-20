class_name FishCaughtPopUp
extends Control

@onready var fish_display: FishDisplay = $FishDisplay

func _ready() -> void:
	print(fish_display)

func set_properties(fish_sprite: Texture, fish_name: String) -> void:
	fish_display.set_fish_sprite(fish_sprite)
	fish_display.set_fish_name(fish_name)
