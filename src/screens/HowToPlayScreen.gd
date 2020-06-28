extends Control


var current_page 


func _ready() -> void:
	get_node("Background").set_frame_color(PlayerData.get_background_colour())
	current_page = 1
	update_display()
	update_button_visibility()


func _on_Button_MainMenu_button_up() -> void:
	AudioManager.play_rand_sfx()
	get_tree().change_scene("res://src/screens/StartScreen.tscn")


func update_button_visibility() -> void: 
	if current_page == 1:
		get_node("HBox_Buttons/Button_Back").disabled = true
		get_node("HBox_Buttons/Button_Next").set_text("Next")
		#get_node("HBox_Buttons/Button_Next").disabled = false
	elif current_page == 2: 
		get_node("HBox_Buttons/Button_Back").disabled = false
		get_node("HBox_Buttons/Button_Next").set_text("Next")
		#get_node("HBox_Buttons/Button_Next").disabled = false
	else: 
		get_node("HBox_Buttons/Button_Back").disabled = false
		get_node("HBox_Buttons/Button_Next").set_text("Start Game!")
		#get_node("HBox_Buttons/Button_Next").disabled = true


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
		var game_start_text = "Select a difficulty level and a grid size to begin."
		var goal_text = "Match all cards as quickly as you can!"
		var goal_img = load("res://assets/images/how_to/HowTo_01.png")
		var difficulty_text = "Higher difficulty levels introduce more shapes and colours."
		text_1 = game_start_text
		text_2 = goal_text
		text_3 = difficulty_text
		get_node("Img_1").show()
		get_node("Img_2").hide()
		get_node("Img_3").hide()
		get_node("Img_4").hide()
		get_node("Img_5").hide()
	# Page 2
	if current_page == 2:
		var controls_directions_text = "Use the 'WASD' keys, the arrow keys, \nor left-mouse clicks to move the selector icon."
		var controls_input_text = "Use the Space key or Enter key to flip a card. \nThe left-mouse click also flips a card."
		
		var failed_match_img = load("res://assets/images/how_to/HowTo_02.png")
		text_1 = controls_directions_text
		text_2 = controls_input_text
		text_3 = ""
		get_node("Img_1").hide()
		get_node("Img_2").show()
		get_node("Img_3").hide()
		get_node("Img_4").hide()
		get_node("Img_5").hide()
	# Page 3
	if current_page == 3: 
		var failed_match_text = "If you flip two cards that don't match, \nthey will turn face down again.\n"
		var colourblind_text = "Colourblind mode disabled: \nCards have a shape and a colour which must be matched.\n\n\nColourblind mode enabled: \nWhite cards use additional background shapes.\n\n"
		var timer_text = "You can see your time at the bottom of the screen. \nIt will be your score."
		text_1 = failed_match_text
		text_2 = colourblind_text
		text_3 = timer_text
		get_node("Img_1").hide()
		get_node("Img_2").hide()
		get_node("Img_3").show()
		get_node("Img_4").show()
		get_node("Img_5").show()
	
	get_node("VBoxContainer/Txt_1").set_text(text_1)
	get_node("VBoxContainer/Txt_2").set_text(text_2)
	get_node("VBoxContainer/Txt_3").set_text(text_3)
