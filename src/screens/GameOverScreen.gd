extends Control


func _ready() -> void:
	victory_sound()
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())
	$VBox/HBoxContainer/StatText.set_text(PlayerData.game_time)

func _on_PlayAgainButton_button_up() -> void:
	get_tree().change_scene("res://src/screens/GameScreen.tscn")


func _on_NewVariants_button_up() -> void:
	get_tree().change_scene("res://src/screens/DifficultySelectionScreen.tscn")

func victory_sound() -> void: 
	if PlayerData.get_sfx_on():
		get_node("VictorySound").set_volume_db(PlayerData.get_sfx_vol())
		get_node("VictorySound").play()
