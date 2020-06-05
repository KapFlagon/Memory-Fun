extends Control


func _ready() -> void:
	AudioManager.play_victory_sound()
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())
	$VBox/HBoxContainer/StatText.set_text(PlayerData.game_time)

func _on_PlayAgainButton_button_up() -> void:
	AudioManager.play_rand_sfx()
	get_tree().change_scene("res://src/screens/GameScreen.tscn")


func _on_NewVariants_button_up() -> void:
	AudioManager.play_rand_sfx()
	get_tree().change_scene("res://src/screens/DifficultySelectionScreen.tscn")

