class_name UI
extends CanvasLayer

const FISH_COLLECTION_PREFAB := preload("res://scenes/ui/fish_collection.tscn")
const POP_UP_PREFAB := preload("res://scenes/ui/fish_caught_pop_up.tscn")
const CATCH_FAIL_SPRITE := preload("res://assets/ui/catch-fail.png")

@onready var reel_bar: TextureRect = %ReelBar
@onready var task_label: Label = %TaskLabel

var fish_collection_screen : FishCollection = null
var pop_up_screen : FishCaughtPopUp = null

func _ready() -> void:
	StateManager.reel_start.connect(onReelStart.bind())
	StateManager.reel_stop.connect(onReelStop.bind())
	StateManager.fish_caught.connect(onFishCaught.bind())
	StateManager.catch_failed.connect(onCatchFailed.bind())
	StateManager.task_info.connect(set_task_label.bind())

func _process(_delta: float) -> void:
	if pop_up_screen and Input.is_action_just_pressed("v"):
		pop_up_screen.queue_free()
		pop_up_screen = null
		StateManager.pop_up_close.emit()
	
	if Input.is_action_just_pressed("c"):
		toggle_fish_collection()

func onReelStart() -> void:
	reel_bar.visible = true

func onReelStop() -> void:
	reel_bar.visible = false

func toggle_fish_collection() -> void:
	if fish_collection_screen:
		fish_collection_screen.close()
		fish_collection_screen = null
	else:
		fish_collection_screen = FISH_COLLECTION_PREFAB.instantiate()
		add_child(fish_collection_screen)

func onFishCaught(fish: FishData) -> void:
	if pop_up_screen:
		pop_up_screen.queue_free()
		pop_up_screen = null
	else:
		pop_up_screen = POP_UP_PREFAB.instantiate()
		add_child(pop_up_screen)
		pop_up_screen.set_properties(fish.fish_sprite, fish.display_name)

func onCatchFailed() -> void:
	if pop_up_screen:
		pop_up_screen.queue_free()
		pop_up_screen = null
	else:
		pop_up_screen = POP_UP_PREFAB.instantiate()
		add_child(pop_up_screen)
		pop_up_screen.set_properties(CATCH_FAIL_SPRITE, "Catch Failed")

func set_task_label(text: String) -> void:
	task_label.text = text
