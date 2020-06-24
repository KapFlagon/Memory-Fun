extends Control


func _ready() -> void:
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())


