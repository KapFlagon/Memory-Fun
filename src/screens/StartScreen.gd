extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())
	if AudioManager.initialized == false:
		AudioManager.check_music()
		AudioManager.initialized = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_OptionsButton_options_submitted() -> void:
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())


func _on_CreditsButton_button_up() -> void:
	get_tree().change_scene("res://src/screens/CreditsScreen.tscn")


func _on_CheckBox_toggled(button_pressed: bool) -> void:
	PlayerData.set_colour_blind_mode_on(button_pressed)
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())
