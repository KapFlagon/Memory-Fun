extends CardBase


enum e_game_state {NEW, ONGOING, WAITING, COMPLETED}
enum e_difficulties {EASY, MEDIUM, HARD}


# Export Variables for Grid
export var columns: int
export var rows: int
export var x_start: int
export var y_start: int
export var item_width: int
export var item_height: int
export var item_padding_x: int
export var item_padding_y: int
var selected_difficulty: int

var game_state = null
var card_grid = []
var CardPreLoad = preload("res://src/entities/game_objects/Card.tscn")
var random = RandomNumberGenerator.new()
var current_selector_position := Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_state = e_game_state.NEW
	selected_difficulty = PlayerData.get_difficulty()
	parse_grid_size()
	card_grid = create_2D_array()
	var card_1D_array = generate_cards()
	card_1D_array = shuffle_cards(card_1D_array, 2)
	populate_2D_grid(card_1D_array)
	prepare_selector()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Check for directional input, move the selector icon
	process_inputs()


func randomize_card_params(): 
	var tempArray = []
	var shape_pool = 0
	var colour_pool = 0
	if selected_difficulty == e_difficulties.EASY:
		shape_pool = 3
		colour_pool = 1
	elif selected_difficulty == e_difficulties.MEDIUM:
		shape_pool = e_shapes.size()
		colour_pool = 3
	else: 
		shape_pool = e_shapes.size()
		colour_pool = e_colours.size()
	random.randomize()
	tempArray.append(random.randi_range(0, shape_pool - 1))  
	random.randomize()
	tempArray.append(random.randi_range(0, colour_pool - 1))
	return tempArray


func create_card(card_params_array):
	var new_card = CardPreLoad.instance()
	new_card.init_card(card_params_array[0], card_params_array[1])
	return new_card
	
	

func populate_2D_grid(card_1D_array):
	for i in columns:
		for j in rows:
			card_grid[i][j] = card_1D_array.pop_back()
			card_grid[i][j].set_position(grid_to_pixel(i, j))


func generate_cards(): 
	var card_counter = 0
	var created_cards = []
	var temp_card_params = randomize_card_params()
	var temp_card 
	var num_of_cards = columns * rows
	# Each card should be added twice, so that there are always pairs
	for n in num_of_cards:
		# Check if new card template needs to be generated. 
		if card_counter < 2:
			card_counter = card_counter + 1
			pass
		else: 
			temp_card_params = randomize_card_params()
			card_counter = 1
		temp_card = create_card(temp_card_params)
		#temp_card.set_position(grid_to_pixel(i, j))
		add_child(temp_card)
		#card_grid[i][j] = temp_card
		created_cards.append(temp_card)
	return created_cards


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
		#card_grid[card_a_grid_location.x][card_a_grid_location.y].set_current_state(e_states.MATCHED)
		#card_grid[card_b_grid_location.x][card_b_grid_location.y].set_current_state(e_states.MATCHED)
	return full_match


func validate_selection(selected_card_grid_location: Vector2):
	var valid_selection = false
	var selected_card_state = card_grid[selected_card_grid_location.x][selected_card_grid_location.y].get_current_state()
	if selected_card_state == e_states.FACE_DOWN or selected_card_state == e_states.FACE_UP:
		valid_selection = true
	return valid_selection


func flip_chosen_card(card_grid_location) -> void:
	if card_grid[card_grid_location.x][card_grid_location.y].get_current_state() == e_states.FACE_DOWN:
		card_grid[card_grid_location.x][card_grid_location.y].set_current_state(e_states.FACE_UP)
	elif card_grid[card_grid_location.x][card_grid_location.y].get_current_state() == e_states.FACE_UP:
		card_grid[card_grid_location.x][card_grid_location.y].set_current_state(e_states.FACE_DOWN)
	check_2D_array_matches()
	check_2D_array_state()


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

func check_2D_array_matches(): 
	var face_up_count = 0
	var card_a_grid_pos = null
	var card_b_grid_pos = null
	var matched = false
	
	for i in columns:
		for j in rows: 
			if card_grid[i][j].get_current_state() == e_states.FACE_UP:
				face_up_count = face_up_count + 1
				if face_up_count == 1:
					card_a_grid_pos = Vector2(i,j)
				elif face_up_count == 2:
					card_b_grid_pos = Vector2(i,j)
	if face_up_count == 2:
		matched = check_pair(card_a_grid_pos, card_b_grid_pos)
		if matched:
			card_grid[card_a_grid_pos.x][card_a_grid_pos.y].set_current_state(e_states.MATCHED)
			card_grid[card_b_grid_pos.x][card_b_grid_pos.y].set_current_state(e_states.MATCHED)
		elif not matched: 
			var t = Timer.new()
			t.set_wait_time(0.75)
			t.set_one_shot(true)
			self.add_child(t)
			game_state = e_game_state.WAITING
			t.start()
			yield(t, "timeout")
			t.queue_free()
			game_state = e_game_state.ONGOING
			card_grid[card_a_grid_pos.x][card_a_grid_pos.y].set_current_state(e_states.FACE_DOWN)
			card_grid[card_b_grid_pos.x][card_b_grid_pos.y].set_current_state(e_states.FACE_DOWN)



func check_2D_array_state() -> void: 
	var matched_count = 0
	for i in columns:
		for j in rows: 
			if card_grid[i][j].get_current_state() == e_states.MATCHED:
				matched_count = matched_count + 1 
	print("matched_count:" + str(matched_count))
	if matched_count == (columns * rows):
		game_state = e_game_state.COMPLETED
		print("game over")


func shuffle_cards(card_1D_array, num_of_shuffles: int):
	# https://bost.ocks.org/mike/shuffle/  ? 
	for n in range(num_of_shuffles): 
		card_1D_array.shuffle()
	return card_1D_array


func prepare_selector() -> void:
	current_selector_position = Vector2(0, 0)
	set_selector_position()
	game_state = e_game_state.ONGOING


func update_selection_icon_location(location_change: Vector2) -> void:
	var tempVec2 = current_selector_position
	tempVec2.x = tempVec2.x + location_change.x
	tempVec2.y = tempVec2.y + location_change.y
	if tempVec2.x >= 0 and tempVec2.y >= 0:
		if tempVec2.x < columns and tempVec2.y < rows:
			current_selector_position = tempVec2
			set_selector_position()

func set_selector_position() -> void:
	var temp_new_pixels = grid_to_pixel(current_selector_position.x, current_selector_position.y)
	temp_new_pixels.x = temp_new_pixels.x - 5
	temp_new_pixels.y = temp_new_pixels.y - 5
	get_node("SelectionIcon").position = temp_new_pixels


func process_inputs() -> void:
	if game_state == e_game_state.ONGOING:
		if Input.is_action_just_pressed("ui_right"):
			update_selection_icon_location(Vector2(1,0))
		if Input.is_action_just_pressed("ui_left"):
			update_selection_icon_location(Vector2(-1,0))
		if Input.is_action_just_pressed("ui_up"):
			update_selection_icon_location(Vector2(0,-1))
		if Input.is_action_just_pressed("ui_down"):
			update_selection_icon_location(Vector2(0,1))
		if Input.is_action_just_released("ui_accept") or Input.is_action_just_released("ui_select"):
			print("ui_accept or ui_select detected")
			var valid_selection = validate_selection(current_selector_position)
			if valid_selection:
				flip_chosen_card(current_selector_position)
		if Input.is_action_just_released("ui_end"): 
			print()
	elif game_state == e_game_state.WAITING:
		# No input allowed
		pass

func parse_grid_size() -> void:
	match PlayerData.get_grid_size():
		8:
			columns = 4
			rows = 2
		12:
			columns = 4
			rows = 3
		16: 
			columns = 4
			rows = 4
		20: 
			columns = 4
			rows = 5
		24: 
			columns = 4
			rows = 6
