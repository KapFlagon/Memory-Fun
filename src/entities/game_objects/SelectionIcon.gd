extends Node2D

var origin_x: int setget set_origin_x, get_origin_x
var origin_y: int setget set_origin_y, get_origin_y

func set_origin_x(new_origin_x) -> void:
	origin_x = new_origin_x


func get_origin_x():
	return origin_x


func set_origin_y(new_origin_y) -> void:
	origin_y = new_origin_y


func get_origin_y():
	return origin_y


func set_selector_pos(new_pos: Vector2) -> void:
	set_origin_x(new_pos.x)
	set_origin_y(new_pos.y)
