extends Node2D


func _ready() -> void:
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())


func _process(delta: float) -> void:
	process_inputs()


func process_inputs() -> void:
	if Input.is_action_just_released("ui_cancel"): 
		get_tree().paused = true
		get_node("PauseDialog").popup_centered_clamped()


#func _on_ResumeButton_button_up() -> void:
#	get_node("PauseDialog").hide()
#	get_tree().paused = false


func _on_PauseDialog_pause_options_submitted() -> void:
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())
	get_node("GridManager").update_grid_colour_blind()


#func _on_MainMenuButton_button_up() -> void:
#	get_tree().paused = false
#	get_tree().change_scene("res://src/screens/StartScreen.tscn")

