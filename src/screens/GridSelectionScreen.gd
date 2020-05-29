extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for button in get_tree().get_nodes_in_group("GridSelectGroup"):
		button.connect("button_up", self, "_grid_button_pressed", [button]) 
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_BackButton_button_up() -> void:
	get_tree().change_scene("res://src/screens/DifficultySelectionScreen.tscn")


func _grid_button_pressed(button):
	if button.name == "8TileGridButton":
		print("8")
		PlayerData.set_grid_size(8)
	elif button.name == "12TileGridButton":
		print("12")
		PlayerData.set_grid_size(12)
	elif button.name == "16TileGridButton":
		print("16")
		PlayerData.set_grid_size(16)
	elif button.name == "20TileGridButton":
		print("20")
		PlayerData.set_grid_size(20)
	elif button.name == "24TileGridButton":
		print("24")
		PlayerData.set_grid_size(24)
	else:
		print("custom")
		# New scene for specifying custom grid
	next_scene()

func next_scene() -> void:
	get_tree().change_scene("res://src/screens/TestGameScreen.tscn")
	
