extends Node

var music_on := true setget set_music_on, get_music_on
var music_vol := 0 setget set_music_vol, get_music_vol
var sfx_on := true setget set_sfx_on, get_sfx_on
var sfx_vol := 0 setget set_sfx_vol, get_sfx_vol
var initialized := false
var random = RandomNumberGenerator.new()


func set_music_on(val: bool) -> void:
	music_on = val
	check_music()


func get_music_on():
	return music_on


func set_music_vol(val) -> void:
	music_vol = val 
	get_node("Music").set_volume_db(music_vol)


func get_music_vol():
	return music_vol


func set_sfx_on(val: bool) -> void: 
	sfx_on = val


func get_sfx_on():
	return sfx_on


func set_sfx_vol(val) -> void:
	sfx_vol = val
	play_rand_sfx()


func get_sfx_vol():
	return sfx_vol


func check_music() -> void:
	if get_music_on():
		get_node("Music").set_volume_db(get_music_vol())
		var current_position = get_node("Music").is_playing()
		if current_position == false:
			get_node("Music").play(0)
	else: 
		get_node("Music").stop()


func play_rand_sfx() -> void:
	var rand_sound = random.randi_range(0, 2)
	var sfx_vol = AudioManager.get_sfx_vol()
	match rand_sound:
		0: 
			get_node("SFX_01").set_volume_db(get_sfx_vol())
			get_node("SFX_01").play()
		1: 
			get_node("SFX_02").set_volume_db(get_sfx_vol())
			get_node("SFX_02").play()
		2: 
			get_node("SFX_03").set_volume_db(get_sfx_vol())
			get_node("SFX_03").play()


func play_victory_sound() -> void: 
	if AudioManager.get_sfx_on():
		get_node("VictorySound").set_volume_db(get_sfx_vol())
		get_node("VictorySound").play()
