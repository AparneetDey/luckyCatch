extends Node

signal cast_bobber
signal fish_bite
signal reel_start
signal reel_stop

signal update_reel_indicator(value: float)
signal update_safe_zone(size: float, position: float)

signal fish_caught(fish: FishData)
signal catch_failed

signal pop_up_close

signal task_info(text: String)
