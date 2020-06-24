extends Control


var start_time
var elapsed_time 


func _ready() -> void:
	start_time = OS.get_unix_time()


func _process(delta): 
	update_time_label()


func update_time_label():
	var time_now = OS.get_unix_time()
	var elapsed_time = time_now - start_time
	PlayerData.set_game_time_secs(elapsed_time)
	var str_elapsed_time = PlayerData.secs_to_string(elapsed_time)
	$VBox/Time_L.set_text(str_elapsed_time)


func _on_PauseDialog_unpaused(elapsed_pause_time) -> void:
	start_time = start_time + elapsed_pause_time
