extends CardBase

# variables
export (int) var current_state setget set_current_state, get_current_state
export (int) var shape setget set_shape, get_shape
export (int) var colour setget set_colour, get_colour
export (int) var card_back setget set_card_back, get_card_back


var front_img_file
var back_img_file


# functions 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func init_card(new_shape, new_colour, new_card_back) -> void:
	# Using as a "constructor" of sorts
	set_shape(new_shape)
	set_colour (new_colour)
	set_current_state(e_states.FACE_DOWN)
	set_card_back(new_card_back)


func set_current_state(new_state) -> void:
	current_state = new_state
	update_card_visibility()


func get_current_state():
	return current_state


func set_shape(new_shape): 
	shape = new_shape
	load_shape_resource()


func get_shape():
	return shape


func set_colour(new_colour): 
	colour = new_colour
	load_colour_resource()
	load_colour_blind_resource()


func get_colour():
	return colour


func get_card_back():
	return card_back


func set_card_back(new_card_back) -> void: 
	card_back = new_card_back
	load_card_back_resource()


func load_shape_resource() -> void: 
	while front_img_file == null:
		match shape:
			e_shapes.CIRCLE: 
				front_img_file = load("res://assets/images/card_faces/Circle.png") # Godot loads the Resource when it reads the line.
			e_shapes.SQUARE: 
				front_img_file = load("res://assets/images/card_faces/Square.png") 
			e_shapes.TRIANGLE: 
				front_img_file = load("res://assets/images/card_faces/Triangle.png") 
			e_shapes.DIAMOND:
				front_img_file = load("res://assets/images/card_faces/Diamond.png") 
			e_shapes.STAR:
				front_img_file = load("res://assets/images/card_faces/Star.png") 
		get_node("FaceSprite").texture = front_img_file


func load_colour_resource() -> void:
	match colour:
		e_colours.WHITE: 
			get_node("FaceColour").color = Color(1, 1, 1, 1)
		e_colours.YELLOW:
			get_node("FaceColour").color = Color(1, 0.96, 0, 1)
		e_colours.RED:
			get_node("FaceColour").color = Color(0.89, 0, 0.13, 1)
		e_colours.BLUE:
			get_node("FaceColour").color = Color(0.13, 0.67, 0.80, 1)
		e_colours.ORANGE:
			get_node("FaceColour").color = Color(1, 0.38, 0.01, 1)
		e_colours.PURPLE:
			get_node("FaceColour").color = Color(0.80, 0.22, 0.48, 1)
		e_colours.GREEN:
			get_node("FaceColour").color = Color(0.40, 1, 0, 1)


func load_colour_blind_resource() -> void: 
	match colour:
		e_colours.WHITE: 
			get_node("ColourblindSprite").texture = load("res://assets/images/colourblind_aides/ColourBlind_Lines_Point.png")
		e_colours.YELLOW:
			get_node("ColourblindSprite").texture = load("res://assets/images/colourblind_aides/ColourBlind_Lines_X.png")
		e_colours.RED:
			get_node("ColourblindSprite").texture = load("res://assets/images/colourblind_aides/ColourBlind_Lines_Plus.png")
		e_colours.BLUE:
			get_node("ColourblindSprite").texture = load("res://assets/images/colourblind_aides/ColourBlind_Lines_V.png")
		e_colours.ORANGE:
			get_node("ColourblindSprite").texture = load("res://assets/images/colourblind_aides/ColourBlind_Lines_H.png")
		e_colours.PURPLE:
			get_node("ColourblindSprite").texture = load("res://assets/images/colourblind_aides/ColourBlind_Lines_Diag_LR.png")
		e_colours.GREEN:
			get_node("ColourblindSprite").texture = load("res://assets/images/colourblind_aides/ColourBlind_Lines_Diag_RL.png")


func colour_blind_mode_on() -> void: 
	if PlayerData.get_colour_blind_mode_on():
		get_node("FaceColour").color = Color(1, 1, 1, 1)
	else: 
		load_colour_resource()


func update_card_visibility() -> void:
	colour_blind_mode_on()
	if current_state == e_states.FACE_DOWN:
		get_node("BackSprite").show()
		get_node("FaceColour").hide()
		get_node("FaceSprite").hide()
		get_node("ColourblindSprite").hide()
	elif current_state == e_states.FACE_UP or current_state == e_states.MATCHED:
		get_node("BackSprite").hide()
		get_node("FaceColour").show()
		if PlayerData.get_colour_blind_mode_on():
			get_node("ColourblindSprite").show()
		else:
			get_node("ColourblindSprite").hide()
		get_node("FaceSprite").show()


func print_card() -> void:
	print("position: " + str(position) + ", current_state: " + str(current_state) + ", Shape: " + str(shape) + ", Colour: " + str(colour))


func get_width():
	return $Border.get_size().x


func get_height():
	return $Border.get_size().y


func load_card_back_resource() -> void: 
	while back_img_file == null:
		match card_back:
			e_backs.A: 
				back_img_file = load("res://assets/images/card_backs/CardBack_A.png") # Godot loads the Resource when it reads the line.
			e_backs.B: 
				back_img_file = load("res://assets/images/card_backs/CardBack_B.png") 
			e_backs.C: 
				back_img_file = load("res://assets/images/card_backs/CardBack_C.png") 
			e_backs.D: 
				back_img_file = load("res://assets/images/card_backs/CardBack_D.png") 
		get_node("BackSprite").texture = back_img_file
