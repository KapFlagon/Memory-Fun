extends CardBase

# variables
export (int) var currentState setget setCurrentState, getCurrentState
export (int) var shape setget setShape, getShape
export (int) var colour setget setColour, getColour

var imgFile


# functions 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#currentState = e_states.BLANK
	#init(e_shapes.CIRCLE, e_colours.BLUE)
	pass # Replace with function body.

func initCard(newShape, newColour) -> void:
	# Using as a "constructor" of sorts
	setShape(newShape)
	setColour (newColour)
	setCurrentState(e_states.FACE_DOWN)
	
func setCurrentState(newState) -> void:
	currentState = newState
	updateCardVisibility()
	
func getCurrentState():
	return currentState
	
func setShape(newShape): 
	shape = newShape
	loadShapeResource()
	
func getShape():
	return shape
	
func setColour(newColour): 
	colour = newColour
	loadColourResource()
	
func getColour():
	return colour

func loadShapeResource() -> void: 
	while imgFile == null:
		match shape:
			e_shapes.CIRCLE: 
				imgFile = load("res://assets/images/Circle.png") # Godot loads the Resource when it reads the line.
			e_shapes.SQUARE: 
				imgFile = load("res://assets/images/Square.png") 
			e_shapes.TRIANGLE: 
				imgFile = load("res://assets/images/Triangle.png") 
			e_shapes.DIAMOND:
				imgFile = load("res://assets/images/Diamond.png") 
			e_shapes.STAR:
				imgFile = load("res://assets/images/Star.png") 
		get_node("FaceSprite").texture = imgFile
	
func loadColourResource() -> void:
	var rgbaVal
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
			
	
func updateCardVisibility() -> void:
	if currentState == e_states.FACE_DOWN:
		get_node("BackSprite").show()
		get_node("FaceColour").hide()
		get_node("FaceSprite").hide()
	elif currentState == e_states.FACE_UP or currentState == e_states.MATCHED:
		get_node("BackSprite").hide()
		get_node("FaceColour").show()
		get_node("FaceSprite").show()


func _on_Control_gui_input(event: InputEvent) -> void:
	# Detect mouse click / Enter key
	# Detect 
	pass # Replace with function body.

func printCard() -> void:
	#print("position: " + position + ", currentState: " + currentState + ", Shape: " + shape + ", Colour: " + colour)
	pass
