extends Control

var start_time
var time_now setget set_time_now
var end_time
var str_elapsed_time setget , get_str_elapsed_time

func _ready() -> void:
	start_time = OS.get_unix_time()
#	if PlayerData.game_paused:
#		time_now
	#set_process(true)

func _process(delta): 
	update_time_label()
	
func update_time_label():
	time_now = OS.get_unix_time()
	var elapsed_time = time_now - start_time
	var minutes = elapsed_time / 60
	var seconds = elapsed_time % 60
	str_elapsed_time = "%02d : %02d" % [minutes, seconds]
	$VBox/Time_L.set_text(str_elapsed_time)
	PlayerData.set_game_time(str_elapsed_time)


func get_str_elapsed_time():
	return str_elapsed_time


func set_time_now(new_time) -> void:
	var string_array = new_time.split(":", false)
	var a = int(string_array[0]) * 60
	var b = a + int(string_array[1])
