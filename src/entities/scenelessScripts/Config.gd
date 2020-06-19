extends Node


const FILE_PATH = "res://config.cfg"


var config_file = ConfigFile.new()
var settings_dict


func _ready() -> void:
	load_config()
	push_config()


func settings_to_dict(): 
	settings_dict =  {
		"gameplay": {
			"colourblind": PlayerData.get_colour_blind_mode_on(),
			"background_colour": PlayerData.get_background_colour()
		},
		"audio": {
			"music_on": AudioManager.get_music_on(),
			"music_vol": AudioManager.get_music_vol(),
			"sfx_on": AudioManager.get_sfx_on(),
			"sfx_vol": AudioManager.get_sfx_vol()
		}
	}


func save_config():
	settings_to_dict()
	for section in settings_dict.keys():
		for key in settings_dict[section]:
			config_file.set_value(section, key, settings_dict[section][key])
	config_file.save(FILE_PATH)


func load_config():
	settings_to_dict()
	var error = config_file.load(FILE_PATH)
	if error != OK: 
		print("Failed loading config file. Error code is %s" % error)
		# perform a save to try and populate the file with data
		save_config()
		return false
	else:
		for section in settings_dict.keys():
			for key in settings_dict[section]:
				settings_dict[section][key] = config_file.get_value(section, key, null)
		return true


func get_config_parameter(section: String, key: String):
	var output = settings_dict[section][key]
	return output


func push_config():
	PlayerData.set_colour_blind_mode_on(get_config_parameter("gameplay", "colourblind"))
	PlayerData.set_background_colour(get_config_parameter("gameplay", "background_colour"))
	AudioManager.set_music_on(get_config_parameter("audio", "music_on"))
	AudioManager.set_music_vol(get_config_parameter("audio", "music_vol"))
	AudioManager.sfx_on = get_config_parameter("audio", "sfx_on")
	AudioManager.sfx_vol = get_config_parameter("audio", "sfx_vol")
