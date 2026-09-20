class_name FishDisplay
extends TextureRect

@onready var fish_sprite: TextureRect = $FishSprite
@onready var fish_name: Label = $FishName

func set_fish_sprite(sprite: Texture) -> void:
	fish_sprite.texture = sprite

func set_fish_name(display_name: String) -> void:
	fish_name.text = display_name
