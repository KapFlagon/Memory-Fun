extends Button


signal options_submitted


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_OptionsButton_button_up() -> void:
	AudioManager.play_rand_sfx()
	get_node("OptionsPopup").popup_centered_clamped()


func _on_OptionsPopup_popup_submitted() -> void:
	emit_signal("options_submitted")
