extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_ExitButton_button_up() -> void:
	get_tree().quit() 
