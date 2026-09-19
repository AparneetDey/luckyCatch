extends CanvasLayer

@onready var reel_bar: TextureRect = %ReelBar

func _ready() -> void:
	StateManager.reel_start.connect(onReelStart.bind())
	StateManager.reel_stop.connect(onReelStop.bind())

func onReelStart() -> void:
	reel_bar.visible = true

func onReelStop() -> void:
	reel_bar.visible = false
