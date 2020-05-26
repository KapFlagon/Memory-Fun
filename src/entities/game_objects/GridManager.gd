extends CardBase


enum GameState {NEW, ONGOING, COMPLETED}


# Export Variables for Grid
export var columns: int
export var rows: int
export var x_start: int
export var y_start: int
export var item_width: int
export var item_height: int
export var item_padding_x: int
export var item_padding_y: int

var card_grid = []
var CardPreLoad = preload("res://src/entities/game_objects/Card.tscn")
var random = RandomNumberGenerator.new()
var current_selector_position := Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_grid = create_2D_array()
	populate_grid()
	prepare_selector()
	#print(card_grid)
	#print("post shuffle")
	#print_2D_array()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Check for directional input, move the selector icon
	pass


func randomize_card_params(): 
	var tempArray = []
	tempArray.append(random.randi_range(0, e_shapes.size()-1))  
	tempArray.append(random.randi_range(0, e_colours.size()-1))
	return tempArray


func create_card(card_params_array):
	var new_card = CardPreLoad.instance()
	new_card.init_card(card_params_array[0], card_params_array[1])
	return new_card
	
	
func populate_grid():
	var card_counter = 0
	var temp_card_params = randomize_card_params()
	var temp_card 
	# Each card should be added twice, so that there are always pairs
	for i in columns:
		for j in rows:
			# Check if new card template needs to be generated. 
			if card_counter < 2:
				card_counter = card_counter + 1
				pass
			else: 
				temp_card_params = randomize_card_params()
				card_counter = 1
			temp_card = create_card(temp_card_params)
			temp_card.set_position(grid_to_pixel(i, j))
			add_child(temp_card)
			card_grid[i][j] = temp_card
	#print("pre shuffle")
	#print_2D_array()
	#card_grid = shuffle_card_grid(1)
	
	
func grid_to_pixel(column, row):
	var new_x = x_start + (item_width * column) + (item_padding_x * column)
	var new_y = y_start + (item_height * row) + (item_padding_y * row)
	#print("x: " + str(new_x) + ", y: " + str(new_y))
	return Vector2(new_x, new_y)
	
	
func pixel_to_grid(xPos, yPos):
	pass
	
	
func check_pair(card_a_grid_location: Vector2, card_b_grid_location: Vector2): 
	var full_match = false
	var colour_match = false
	var shape_match = false
	if card_grid[card_a_grid_location.x][card_a_grid_location.y].get_shape() == card_grid[card_b_grid_location.x][card_b_grid_location.y].get_shape():
		shape_match = true
	if card_grid[card_a_grid_location.x][card_a_grid_location.y].get_colour() == card_grid[card_b_grid_location.x][card_b_grid_location.y].get_colour():
		colour_match = true
	if shape_match and colour_match:
		full_match = true
		card_grid[card_a_grid_location.x][card_a_grid_location.y].set_current_state(e_states.MATCHED)
		card_grid[card_b_grid_location.x][card_b_grid_location.y].set_current_state(e_states.MATCHED)
	return full_match


func valid_selection(selected_card_grid_location: Vector2):
	var valid_selection = false
	var selected_card_state = card_grid[selected_card_grid_location.x][selected_card_grid_location.y].get_current_state()
	if selected_card_state == e_states.FACE_DOWN or selected_card_state == e_states.FACE_UP:
		valid_selection = true
	return valid_selection


func create_2D_array(): 
	var array = []
	for i in columns:
		array.append([])
		for j in rows:
			array[i].append(null)
	return array


func print_2D_array(): 
	for i in columns:
		for j in rows:
			print("grid number " + str(i) + ", " + str(j))
			card_grid[i][j].print_card()


func validate_selection_icon_location(new_location: Vector2):
	if new_location.x >= 0 and new_location.y >= 0:
		if new_location.x < columns and new_location.y < rows:
			return true
		else:
			return false
	else: 
		return false

func shuffle_card_grid(num_of_shuffles: int):
	# https://bost.ocks.org/mike/shuffle/
	var shuffled_2D_array
	var total_items = columns * rows
	
	#return shuffled_2D_array 
	pass


func prepare_selector() -> void:
	current_selector_position = Vector2(0, 0)
	set_selector_position(current_selector_position)

func set_selector_position(new_grid_pos: Vector2) -> void:
	var temp_new_pixels = grid_to_pixel(new_grid_pos.x, new_grid_pos.y)
	temp_new_pixels.x = temp_new_pixels.x - 5
	temp_new_pixels.y = temp_new_pixels.y - 5
	get_node("SelectionIcon").position = temp_new_pixels
