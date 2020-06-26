extends Control



func _ready() -> void:
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())


func _on_Back_button_up() -> void:
	AudioManager.play_rand_sfx()
	get_tree().change_scene("res://src/screens/StartScreen.tscn")
