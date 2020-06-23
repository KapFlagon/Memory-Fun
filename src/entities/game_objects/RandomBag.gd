extends CardBase


var shape_pool = 0
var colour_pool = 0
var full_bag = []
var current_bag = []


func _ready() -> void: 
	pass


func initialize(difficulty: int) -> void: 
	if difficulty == PlayerData.e_difficulty.EASY:
		shape_pool = 3
		colour_pool = 1
	elif difficulty == PlayerData.e_difficulty.MEDIUM:
		shape_pool = e_shapes.size()
		colour_pool = 3
	else: 
		shape_pool = e_shapes.size()
		colour_pool = e_colours.size()
	generate_full_bag()


func generate_full_bag() -> void: 
	for i in shape_pool: 
		for j in colour_pool: 
			var item = [i, j]
			full_bag.append(item)
	refill_bag(3)


func pull_from_bag(): 
	if current_bag.size() == 0:
		refill_bag(3)
	return current_bag.pop_back()


func refill_bag(num_of_shuffles: int) -> void: 
	for i in num_of_shuffles:
		full_bag.shuffle()
	current_bag = full_bag.duplicate(true)
