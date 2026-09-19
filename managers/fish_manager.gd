extends Node

enum Rarity {
	COMMON,
	UNCOMMON,
	RARE,
	LEGENDARY
}

const FISH_LIST : Array[FishData] = [
	preload("res://fish_resources/sample_fish1.tres"),
	preload("res://fish_resources/sample_fish2.tres"),
	preload("res://fish_resources/sample_fish3.tres"),
	preload("res://fish_resources/sample_fish4.tres"),
]

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
