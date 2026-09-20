class_name SoundManager
extends Node

@onready var sounds : Array[AudioStreamPlayer] = [%SFXRipple, %SFXSplash]

enum Sound {RIPPLE, SPLASH}

func play(sound: Sound, tweakPitch: bool = false):
	var addedPitch := 0.0
	if tweakPitch:
		addedPitch = randf_range(-0.3, 0.3)
	sounds[sound as int].pitch_scale += addedPitch
	sounds[sound as int].play()
