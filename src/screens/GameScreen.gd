extends Node2D

var current_zoom
var zoom_factor = 0.25


func _process(delta: float) -> void:
	# Check for zoom input
	process_inputs()


func _on_ZoomInButton_button_up() -> void:
	if current_zoom > 0:
		zoom_in()


func _on_ZoomOutButton_button_up() -> void:
	zoom_out()


func zoom_out() -> void:
	current_zoom = $Camera2D.get_zoom()
	if current_zoom.x >= 0.25:
		var new_x_zoom = current_zoom.x + zoom_factor
		var new_y_zoom = current_zoom.y + zoom_factor
		$Camera2D.set_zoom(Vector2(new_x_zoom, new_y_zoom))
		print("zoom out")


func zoom_in() -> void:
	current_zoom = $Camera2D.get_zoom()
	if current_zoom.x >= 0.50:
		var new_x_zoom = current_zoom.x - zoom_factor
		var new_y_zoom = current_zoom.y - zoom_factor
		$Camera2D.set_zoom(Vector2(new_x_zoom, new_y_zoom))
		print("zoom in")


func process_inputs():
	if Input.is_action_just_pressed("ui_zoom_in"):
		zoom_in()
	elif Input.is_action_just_pressed("ui_zoom_out"):
		zoom_out()
