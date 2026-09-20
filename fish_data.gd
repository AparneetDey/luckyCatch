class_name FishData
extends Resource

@export_category("Identity")
@export var fish_id : String
@export var display_name : String
@export var rarity : FishManager.Rarity

@export_category("Texture")
@export var fish_sprite : Texture
@export var silhouette_sprite : Texture

@export_category("Difficulty")
@export var safe_zone_start_size: float = 0.35
@export var safe_zone_min_size: float = 0.15

@export var difficulty_interval: float = 5.0

@export var reel_speed: float = 0.75
@export var release_speed: float = 0.5

@export var max_reel_speed: float = 2.5
@export var max_release_speed: float = 1

@export var required_catch_time: float = 20.0

@export var danger_limit : float = 3.0

@export_category("Movement")
@export var movement_radius_x : float = 12.0
@export var movement_radius_y : float = 6.0
@export var movement_speed : float = 4.0

@export_category("Catch")
@export var catch_weight : float = 1.0
