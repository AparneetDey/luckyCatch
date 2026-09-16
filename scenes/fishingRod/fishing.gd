class_name Fishing
extends Node2D

@onready var bamboo_rod: BambooRod = %BambooRod
@onready var bobber: Node2D = %Bobber
@onready var fishing_line: Line2D = %FishingLine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	handleFishingLine()

func handleFishingLine() -> void:
	fishing_line.set_point_position(0, bamboo_rod.line_point.global_position)
	fishing_line.set_point_position(1, bobber.position)
