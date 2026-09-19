class_name FishData
extends Resource

@export_category("Identity")
@export var display_name : String
@export var rarity : FishManager.Rarity

@export_category("Texture")
@export var fish_sprite : Texture2D
@export var silhouette_sprite : Texture2D

@export_category("Difficulty")
@export var safe_zone_size : float = 30.0
@export var reel_resistance : float = 1.0
@export var tension_recovery : float = 1.0

@export_category("Catch")
@export var catch_weight : float = 1.0
