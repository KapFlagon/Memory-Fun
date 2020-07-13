extends Control


var current_page 


func _ready() -> void:
	get_node("Background").set_frame_color(PlayerData.get_background_colour())
	current_page = 1
	ready_texts()
	update_display()
	update_button_visibility()


func _on_Button_MainMenu_button_up() -> void:
	AudioManager.play_rand_sfx()
	get_tree().change_scene("res://src/screens/StartScreen.tscn")


func update_button_visibility() -> void: 
	if current_page == 1:
		get_node("HBox_Buttons/Button_Back").disabled = true
		get_node("HBox_Buttons/Button_Next").set_text(tr("NEXT"))
	elif current_page == 2: 
		get_node("HBox_Buttons/Button_Back").disabled = false
		get_node("HBox_Buttons/Button_Next").set_text(tr("NEXT"))
	else: 
		get_node("HBox_Buttons/Button_Back").disabled = false
		get_node("HBox_Buttons/Button_Next").set_text(tr("START"))


func _on_Button_Back_button_up() -> void:
	AudioManager.play_rand_sfx()
	current_page = current_page - 1
	update_display()
	update_button_visibility()


func _on_Button_Next_button_up() -> void:
	if current_page == 3:
		get_tree().change_scene("res://src/screens/DifficultySelectionScreen.tscn")
	else:
		AudioManager.play_rand_sfx()
		current_page = current_page + 1
		update_display()
		update_button_visibility()


func update_display() -> void:
	# clear current textures before performing further assignments? 
	var text_1
	var img_1 = null
	var text_2
	var img_2 = null
	var text_3
	var img_3 = null


	# Page 1
	if current_page == 1:
		text_1 = tr("HTPS_GAME_START")
		text_2 = tr("HTPS_GOAL")
		text_3 = tr("HTPS_DIFF")
		get_node("Img_1").show()
		get_node("Img_2").hide()
		get_node("Img_3").hide()
		get_node("Img_4").hide()
		get_node("Img_5").hide()
	# Page 2
	if current_page == 2:
		text_1 = tr("HTPS_CONTROLS_MOVEMENT")
		text_2 = tr("HTPS_CONTROLS_INPUT")
		text_3 = ""
		get_node("Img_1").hide()
		get_node("Img_2").show()
		get_node("Img_3").hide()
		get_node("Img_4").hide()
		get_node("Img_5").hide()
	# Page 3
	if current_page == 3: 
		text_1 = tr("HTPS_NO_MATCH")
		text_2 = tr("HTPS_COLOURBLIND")
		text_3 = tr("HTPS_TIMER")
		get_node("Img_1").hide()
		get_node("Img_2").hide()
		get_node("Img_3").show()
		get_node("Img_4").show()
		get_node("Img_5").show()
	
	get_node("VBoxContainer/Txt_1").set_text(text_1)
	get_node("VBoxContainer/Txt_2").set_text(text_2)
	get_node("VBoxContainer/Txt_3").set_text(text_3)


func ready_texts() -> void:
	$Title.set_text(tr("HOW_TO_PLAY"))
	$HBox_Buttons/Button_Back.set_text(tr("BACK"))
	$HBox_Buttons/Button_MainMenu.set_text(tr("MAIN_MENU"))
