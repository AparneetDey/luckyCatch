extends CanvasLayer

const POP_UP_PREFAB := preload("res://scenes/ui/fish_caught_pop_up.tscn")
const CATCH_FAIL_SPRITE := preload("res://assets/ui/catch-fail.png")

@onready var reel_bar: TextureRect = %ReelBar

var pop_up_screen : FishCaughtPopUp = null

func _ready() -> void:
	StateManager.reel_start.connect(onReelStart.bind())
	StateManager.reel_stop.connect(onReelStop.bind())
	StateManager.fish_caught.connect(onFishCaught.bind())
	StateManager.catch_failed.connect(onCatchFailed.bind())

func _process(_delta: float) -> void:
	if pop_up_screen and Input.is_action_just_pressed("v"):
		pop_up_screen.queue_free()
		pop_up_screen = null
		StateManager.pop_up_close.emit()

func onReelStart() -> void:
	reel_bar.visible = true

func onReelStop() -> void:
	reel_bar.visible = false

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
