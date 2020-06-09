extends PopupDialog

var pause_start_time
var pause_end_time
var total_pause_time setget , get_total_pause_time

signal unpaused(total_time)
signal pause_options_submitted


func _ready() -> void:
	pause_start_time = OS.get_unix_time()


func _process(delta): 
	update_timer()
	
	
func update_timer():
	pause_end_time = OS.get_unix_time()


func get_total_pause_time():
	return total_pause_time


func _on_PauseDialog_popup_hide() -> void:
	total_pause_time = pause_end_time - pause_start_time
	emit_signal("unpaused", get_total_pause_time())


func _on_ResumeButton_button_up() -> void:
	hide()
	get_tree().paused = false


func _on_OptionsButton_options_submitted() -> void:
	#get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())
	emit_signal("pause_options_submitted")


func _on_MainMenuButton_button_up() -> void:
	get_tree().paused = false
	get_tree().change_scene("res://src/screens/StartScreen.tscn")
