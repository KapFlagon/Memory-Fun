extends CardBase


enum e_game_state {NEW, ONGOING, WAITING, COMPLETED}


# Export Variables for Grid
var columns: int
var rows: int
var x_start: int
var y_start: int
var item_width: int
var item_height: int
var item_scale: float 
export var item_padding_x: int
export var item_padding_y: int
var selected_difficulty: int
onready var screen_size = get_viewport().get_visible_rect().size

var game_state = null
var card_grid = []
var CardPreLoad = preload("res://src/entities/game_objects/Card.tscn")
var random = RandomNumberGenerator.new()
var current_selector_position := Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Check for directional input, move the selector icon
	process_inputs()


func scale_width(): 
	return item_width * item_scale


func scale_height(): 
	return item_height * item_scale


func scale_item_padding_x():
	return item_padding_x * item_scale


func scale_item_padding_y(): 
	return item_padding_y * item_scale


func create_card(card_params_array):
	var new_card = CardPreLoad.instance()
	new_card.init_card(card_params_array[0], card_params_array[1])
	new_card.set_scale(Vector2(item_scale,item_scale))
	return new_card


func populate_2D_grid(card_1D_array):
	for i in columns:
		for j in rows:
			card_grid[i][j] = card_1D_array.pop_back()
			card_grid[i][j].set_position(grid_to_pixel(i, j))


func generate_cards(): 
	var card_counter = 0
	var created_cards = []
	get_node("RandomBag").initialize(selected_difficulty)
	var temp_card_params = get_node("RandomBag").pull_from_bag()
	var temp_card 
	var num_of_cards = columns * rows
	# Each card should be added twice, so that there are always pairs
	for n in num_of_cards:
		# Check if new card template needs to be generated. 
		if card_counter < 2:
			card_counter = card_counter + 1
		else: 
			temp_card_params = get_node("RandomBag").pull_from_bag()
			card_counter = 1
		temp_card = create_card(temp_card_params)
		add_child(temp_card)
		created_cards.append(temp_card)
	return created_cards


func grid_to_pixel(column, row):
	var scaled_width = scale_width()
	var scaled_height = scale_height()
	var scaled_padding_x = scale_item_padding_x()
	var scaled_padding_y = scale_item_padding_y()
	var new_x = x_start + ((scaled_width + scaled_padding_x) * column)
	var new_y = y_start + ((scaled_height + scaled_padding_y) * row)
	#print("x: " + str(new_x) + ", y: " + str(new_y))
	return Vector2(new_x, new_y)
	
	
func pixel_to_grid(pos : Vector2):
	var scaled_width = scale_width()
	var scaled_height = scale_height()
	var scaled_padding_x = scale_item_padding_x()
	var scaled_padding_y = scale_item_padding_y()
	var calc_col = floor((pos.x - x_start) / (scaled_padding_x + scaled_width))
	#print("mouse pos x: " + str(pos.x) + " column calc: " + str(calc_col))
	var calc_row = floor((pos.y  - y_start - scaled_padding_y) / scaled_height)
	#print("mouse pos y: " + str(pos.y) + " row calc: " + str(calc_row))
	return Vector2(calc_col, calc_row)


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
	#print("matched_count:" + str(matched_count))
	if matched_count == (columns * rows):
		game_state = e_game_state.COMPLETED
		get_tree().change_scene("res://src/screens/GameOverScreen.tscn")


func shuffle_cards(card_1D_array, num_of_shuffles: int):
	# https://bost.ocks.org/mike/shuffle/  ? 
	for n in range(num_of_shuffles): 
		card_1D_array.shuffle()
	return card_1D_array


func prepare_selector() -> void:
	get_node("SelectionIcon").set_scale(Vector2(item_scale, item_scale))
	current_selector_position = Vector2(0, 0)
	set_selector_position()
	game_state = e_game_state.ONGOING


func update_selection_icon_location(new_location: Vector2):
	if new_location.x >= 0 and new_location.x < columns:
		if new_location.y >= 0 and new_location.y < rows:
			current_selector_position = new_location
			set_selector_position()
			return true
		else:
			 return false
	else:
		 return false


func set_selector_position() -> void:
	var temp_new_pixels = grid_to_pixel(current_selector_position.x, current_selector_position.y)
	temp_new_pixels.x = temp_new_pixels.x - 5
	temp_new_pixels.y = temp_new_pixels.y - 5
	get_node("SelectionIcon").position = temp_new_pixels


func process_inputs() -> void:
	if game_state == e_game_state.ONGOING:
		var new_location = Vector2(0, 0) 
		var right_movement = Vector2(1, 0)
		var left_movement = Vector2(-1, 0)
		var up_movement = Vector2(0, -1)
		var down_movement = Vector2(0, 1)
		if Input.is_action_just_pressed("ui_right"):
			new_location = current_selector_position + right_movement
			update_selection_icon_location(new_location)
		if Input.is_action_just_pressed("ui_left"):
			new_location = current_selector_position + left_movement
			update_selection_icon_location(new_location)
		if Input.is_action_just_pressed("ui_up"):
			new_location = current_selector_position + up_movement
			update_selection_icon_location(new_location)
		if Input.is_action_just_pressed("ui_down"):
			new_location = current_selector_position + down_movement
			update_selection_icon_location(new_location)
		if Input.is_action_just_pressed("ui_accept"): #or Input.is_action_just_released("ui_select"):
			AudioManager.play_rand_sfx()
			#print("ui_accept or ui_select detected")
			var valid_selection = validate_selection(current_selector_position)
			if valid_selection:
				flip_chosen_card(current_selector_position)
		if Input.is_action_just_released("ui_end"): 
			print()
		if Input.is_action_just_pressed("ui_touch"):
			process_touch()
	elif game_state == e_game_state.WAITING:
		# No input allowed
		pass

func parse_grid_size() -> void:
	match PlayerData.get_grid_size():
		8:
			columns = 4
			rows = 2
			item_scale = 0.85
		12:
			columns = 4
			rows = 3
			item_scale = 0.55
		16: 
			columns = 4
			rows = 4
			item_scale = 0.41
		20: 
			columns = 5
			rows = 4
			item_scale = 0.41
		24: 
			columns = 6
			rows = 4
			item_scale = 0.41


func calculate_dimensions() -> void:
	var scaled_item_width = scale_width()
	var scaled_item_height = scale_height()
	var scaled_padding_x = scale_item_padding_x()
	var scaled_padding_y = scale_item_padding_y()
	var play_width = (columns * scaled_item_width) + ((columns - 1) * scaled_padding_x)
	var play_height = (rows * scaled_item_height) + ((rows - 1) * scaled_padding_y)
	var dead_space_width = screen_size.x - play_width
	var dead_space_height = screen_size.y - play_height
	x_start = dead_space_width / 2
	y_start = dead_space_height / 2


func process_touch() -> void:
	var input_position = get_global_mouse_position()
	var new_cursor_grid = pixel_to_grid(input_position)
	var valid_touch = update_selection_icon_location(new_cursor_grid)
	var valid_selection = validate_selection(current_selector_position)
	if valid_touch and valid_selection:
		flip_chosen_card(current_selector_position)


func new_game() -> void: 
	game_state = e_game_state.NEW
	selected_difficulty = PlayerData.get_difficulty()
	parse_grid_size()
	card_grid = create_2D_array()
	var card_1D_array = generate_cards()
	item_width = card_1D_array[0].get_width()
	item_height = card_1D_array[0].get_height()
	card_1D_array = shuffle_cards(card_1D_array, 2)
	calculate_dimensions()
	populate_2D_grid(card_1D_array)
	prepare_selector()


func update_grid_colour_blind() -> void:
	for i in columns:
		for j in rows: 
			card_grid[i][j].update_card_visibility()
