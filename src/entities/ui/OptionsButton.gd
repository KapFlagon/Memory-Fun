extends Button


signal popup_hidden


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_OptionsButton_button_up() -> void:
	AudioManager.play_rand_sfx()
	get_node("OptionsPopup").popup_centered_clamped()


func _on_OptionsPopup_popup_submitted() -> void:
	send_signal()


func _on_OptionsPopup_popup_hide() -> void:
	send_signal()


func send_signal() -> void:
	emit_signal("popup_hidden")
