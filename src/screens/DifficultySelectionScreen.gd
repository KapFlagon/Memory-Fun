extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
enum E_Difficulty {EASY, MEDIUM, HARD}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for button in get_tree().get_nodes_in_group("DifficultyGroup"):
		button.connect("button_up", self, "_difficulty_button_pressed", [button]) 
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _on_BackButton_button_up() -> void:
	get_tree().change_scene("res://src/screens/StartScreen.tscn")

func setDifficulty(difficultyVar) -> void: 
	# code here to pass selected difficulty to a config file or something
	get_tree().change_scene("res://src/screens/GridSelectionScreen.tscn")

func _difficulty_button_pressed(button):
	if button.name == "EasyDifButton":
		#print(button.name)
		setDifficulty(E_Difficulty.EASY)
	elif button.name == "MedDifButton":
		#print(button.name)
		setDifficulty(E_Difficulty.MEDIUM)
	else: 
		#print(button.name)
		setDifficulty(E_Difficulty.HARD)
