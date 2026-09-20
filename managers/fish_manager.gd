extends Node

enum Rarity {
	COMMON,
	UNCOMMON,
	RARE,
	LEGENDARY
}

const FISH_LIST : Array[FishData] = [
	preload("res://fish_resources/jacket_fish.tres"),
	preload("res://fish_resources/looking_heart.tres"),
	preload("res://fish_resources/salmon.tres"),
	preload("res://fish_resources/space_worm.tres"),
	preload("res://fish_resources/useless_can.tres"),
	preload("res://fish_resources/venomu.tres"),
	preload("res://fish_resources/weird_plant.tres"),
	
]

var fish_collection : Dictionary = {}

func get_rarity() -> Rarity:
	var chance := randf_range(0, 1)
	
	if chance < 0.5:
		return Rarity.COMMON
	elif chance < 0.75:
		return Rarity.UNCOMMON
	elif chance < 0.90:
		return Rarity.RARE
	return Rarity.LEGENDARY

func select_fish() -> FishData:
	var rarity : Rarity = get_rarity()
	var fish_of_rarity : Array = []
	
	for fish in FISH_LIST:
		if fish.rarity == rarity:
			fish_of_rarity.append(fish)
	
	var ind : int = randi_range(0, fish_of_rarity.size() - 1)
	
	return fish_of_rarity[ind]

func is_fish_caught(fish_id: String) -> bool:
	return fish_collection.has(fish_id)
