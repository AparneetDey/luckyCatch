class_name FishCollection
extends Control

const DISPLAY_PREFAB := preload("res://scenes/ui/fish_display.tscn")

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var scroll_container: ScrollContainer = %ScrollContainer
@onready var fish_grid: GridContainer = %FishGrid

func _ready() -> void:
	populate()
	animation_player.play("slide_in")

func _enter_tree() -> void:
	get_tree().paused = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		scroll_container.scroll_vertical -= 20
	elif event.is_action_pressed("down"):
		scroll_container.scroll_vertical += 20

func populate() -> void:
	for display: FishDisplay in fish_grid.get_children():
		display.queue_free()
	for fish: FishData in FishManager.FISH_LIST:
		var caught : bool = FishManager.is_fish_caught(fish.fish_id)
		var display_fish : FishDisplay = DISPLAY_PREFAB.instantiate()
		
		fish_grid.add_child(display_fish)
		
		if caught:
			display_fish.set_fish_sprite(fish.fish_sprite)
			display_fish.set_fish_name(fish.display_name)
		else:
			display_fish.set_fish_sprite(fish.silhouette_sprite)
			display_fish.set_fish_name("-----")

func close() -> void:
	animation_player.play("slide_out")

func _exit_tree() -> void:
	get_tree().paused = false
