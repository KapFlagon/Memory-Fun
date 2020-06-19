extends Control


var current_page 


func _ready() -> void:
	get_node("Background").set_frame_color(PlayerData.get_background_colour())
	current_page = 1
	update_display()
	update_button_visibility()


func _on_Button_MainMenu_button_up() -> void:
	get_tree().change_scene("res://src/screens/StartScreen.tscn")


func update_button_visibility() -> void: 
	if current_page == 1:
		get_node("HBox_Buttons/Button_Back").disabled = true
		get_node("HBox_Buttons/Button_Next").disabled = false
	elif current_page == 2: 
		get_node("HBox_Buttons/Button_Back").disabled = false
		get_node("HBox_Buttons/Button_Next").disabled = false
	else: 
		get_node("HBox_Buttons/Button_Back").disabled = false
		get_node("HBox_Buttons/Button_Next").disabled = true


func _on_Button_Back_button_up() -> void:
	current_page = current_page - 1
	update_display()
	update_button_visibility()


func _on_Button_Next_button_up() -> void:
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
		var goal_text = "Match all cards as quick as you can!"
		var goal_img = load("res://assets/images/how_to/HowTo_01.png")
		var difficulty_text = "Higher difficulty levels introduce more shapes and colours."
		text_1 = game_start_text
		text_2 = goal_text
		img_2 = goal_img
		text_3 = difficulty_text
	# Page 2
	if current_page == 2:
		var controls_directions_text = "Use the 'WASD' keys, the arrow keys, or left-mouse clicks to move the selector icon."
		var controls_input_text = "Use the Space key or Enter key to flip a card. The left-mouse click also flips card."
		var failed_match_text = "If you flip two cards that don't match, they will turn face down again."
		var failed_match_img = load("res://assets/images/how_to/HowTo_02.png")
		text_1 = controls_directions_text
		text_2 = controls_input_text
		text_3 = failed_match_text
		img_3 = failed_match_img
	# Page 3
	if current_page == 3: 
		var colourblind_off_text = "When colourblind mode is disabled, cards have a shape and a colour which must be matched."
		var colourblind_off_img = load("res://assets/images/how_to/HowTo_03.png")
		var colourblind_on_text = "When colourblind mode is enabled, cards have no colours and instead use additional background shapes."
		var colourblind_on_img = load("res://assets/images/how_to/HowTo_04.png")
		var timer_text = "You can see your time at the bottom of the screen. It will be your score."
		var timer_img = load("res://assets/images/how_to/HowTo_05.png")
		text_1 = colourblind_off_text
		img_1 = colourblind_off_img
		text_2 = colourblind_on_text
		img_2 = colourblind_on_img
		text_3 = timer_text
		img_3 = timer_img
	
	get_node("VBoxContainer/HBox_1/Txt_1").set_text(text_1)
	get_node("VBoxContainer/HBox_2/Txt_2").set_text(text_2)
	get_node("VBoxContainer/HBox_3/Txt_3").set_text(text_3)
	
	if img_1 != null:
		pass
		
	if img_2 != null: 
		pass
	if img_3 != null: 
		pass
	
