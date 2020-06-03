extends Control


func _ready() -> void:
	$VBox/HBoxContainer/StatText.set_text(PlayerData.game_time)

func _on_PlayAgainButton_button_up() -> void:
	get_tree().change_scene("res://src/screens/GameScreen.tscn")
