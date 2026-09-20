extends TextureRect

const BAR_WIDTH := 70

@onready var reel_indicator: TextureRect = %ReelIndicator
@onready var safe_zone: TextureRect = %SafeZone

var tension : float = 0.0
var safe_zone_position : float = 0.0
var safe_zone_width : float = 0.0

func _ready() -> void:
	StateManager.update_reel_indicator.connect(set_tension.bind())
	StateManager.update_safe_zone.connect(set_safe_zone.bind())

func set_tension(value: float) -> void:
	tension = clamp(value, 0.0, 1.0)
	update()

func set_safe_zone(size: float, position: float) -> void:
	safe_zone.size.x = size * BAR_WIDTH
	safe_zone.position.x = position * BAR_WIDTH

func update() -> void:
	reel_indicator.position.x = tension * BAR_WIDTH - reel_indicator.size.x / 2
