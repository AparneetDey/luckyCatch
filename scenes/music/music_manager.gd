class_name MusicManager
extends Node

const MAIN_THEME_AUDIO := preload("res://assets/music/main-theme.mp3")

@onready var music_stream_player: AudioStreamPlayer = $MusicStreamPlayer

var current_audio_stream : AudioStream = null

func _ready() -> void:
	current_audio_stream = MAIN_THEME_AUDIO
	if current_audio_stream:
		music_stream_player.stream = current_audio_stream
		music_stream_player.stream.loop = true
		music_stream_player.play()
