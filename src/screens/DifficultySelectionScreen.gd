extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
enum e_difficulty {EASY, MEDIUM, HARD}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())
	for button in get_tree().get_nodes_in_group("DifficultyGroup"):
		button.connect("button_up", self, "_difficulty_button_pressed", [button]) 
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _on_BackButton_button_up() -> void:
	get_tree().change_scene("res://src/screens/StartScreen.tscn")

func next_scene() -> void: 
	get_tree().change_scene("res://src/screens/GridSelectionScreen.tscn")

func _difficulty_button_pressed(button):
	if button.name == "EasyDifButton":
		PlayerData.set_difficulty(e_difficulty.EASY)
	elif button.name == "MedDifButton":
		PlayerData.set_difficulty(e_difficulty.MEDIUM)
	else: 
		PlayerData.set_difficulty(e_difficulty.HARD)
	next_scene()
