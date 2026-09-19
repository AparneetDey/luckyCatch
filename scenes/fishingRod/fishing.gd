class_name Fishing
extends Node2D

@onready var bamboo_rod: BambooRod = %BambooRod
@onready var bobber: Bobber = %Bobber
@onready var fishing_line: Line2D = %FishingLine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	handleFishingLine()

func handleFishingLine() -> void:
	var rod_point := fishing_line.to_local(bamboo_rod.line_point.global_position)
	var bobber_point := fishing_line.to_local(bobber.line_point.global_position)
	fishing_line.set_point_position(0, rod_point)
	fishing_line.set_point_position(1, bobber_point)
