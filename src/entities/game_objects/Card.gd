extends CardBase

# variables
export (int) var current_state setget set_current_state, get_current_state
export (int) var shape setget set_shape, get_shape
export (int) var colour setget set_colour, get_colour

var img_file


# functions 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func init_card(new_shape, new_colour) -> void:
	# Using as a "constructor" of sorts
	set_shape(new_shape)
	set_colour (new_colour)
	set_current_state(e_states.FACE_DOWN)


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


func get_colour():
	return colour


func load_shape_resource() -> void: 
	while img_file == null:
		match shape:
			e_shapes.CIRCLE: 
				img_file = load("res://assets/images/Circle.png") # Godot loads the Resource when it reads the line.
			e_shapes.SQUARE: 
				img_file = load("res://assets/images/Square.png") 
			e_shapes.TRIANGLE: 
				img_file = load("res://assets/images/Triangle.png") 
			e_shapes.DIAMOND:
				img_file = load("res://assets/images/Diamond.png") 
			e_shapes.STAR:
				img_file = load("res://assets/images/Star.png") 
		get_node("FaceSprite").texture = img_file


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


func update_card_visibility() -> void:
	if current_state == e_states.FACE_DOWN:
		get_node("BackSprite").show()
		get_node("FaceColour").hide()
		get_node("FaceSprite").hide()
	elif current_state == e_states.FACE_UP or current_state == e_states.MATCHED:
		get_node("BackSprite").hide()
		get_node("FaceColour").show()
		get_node("FaceSprite").show()


func print_card() -> void:
	print("position: " + str(position) + ", current_state: " + str(current_state) + ", Shape: " + str(shape) + ", Colour: " + str(colour))


func get_width():
	return $Border.get_size().x


func get_height():
	return $Border.get_size().y
