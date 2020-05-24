extends CardBase

var cardGrid = []
var cardPreLoad = preload("res://src/entities/game_objects/Card.tscn")
var random = RandomNumberGenerator.new()

# Grid Variables
export (int) var columns
export var rows: int
export var x_start: int
export var y_start: int
export var offset: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cardGrid = create2dArray()
	populateGrid()
	print(cardGrid)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func randomizeCardParams(): 
	var tempArray = []
	tempArray.append(random.randi_range(0, e_shapes.size()-1))  
	tempArray.append(random.randi_range(0, e_colours.size()-1))
	return tempArray

func createCard(cardParamsArray):
	var newCard = cardPreLoad.instance()
	newCard.initCard(cardParamsArray[0], cardParamsArray[1])
	return newCard
	
func populateGrid():
	var cardCounter = 0
	var tempCardParams = randomizeCardParams()
	var tempCard 
	# Each card should be added twice, so that there are always pairs
	for i in columns:
		for j in rows:
			if cardCounter < 2:
				# append to array
				cardCounter = cardCounter + 1
				pass
			else: 
				tempCardParams = randomizeCardParams()
				cardCounter = 1
			#get_tree().get_root().add_child(tempCard)
			tempCard = createCard(tempCardParams)
			tempCard.set_position(grid_to_pixel(i, j))
			add_child(tempCard)
			#cardGrid[i].append(tempCard)
	cardGrid.shuffle()
	
	
func grid_to_pixel(column, row):
	var new_x = x_start + offset * column
	var new_y = y_start + -offset * row
	return Vector2(new_x, new_y)
	
#func checkPair(card_A: Card, card_B: Card): 
#	var checkResult := true
#	return checkResult
#	pass

func create2dArray(): 
	var array = []
	for i in columns:
		array.append([])
		for j in rows:
			array[i].append(null)
	return array

func print2Darray(): 
	for i in cardGrid:
		for j in cardGrid[i]:
			j.printCard()
