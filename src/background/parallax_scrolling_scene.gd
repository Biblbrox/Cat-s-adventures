@tool
extends Node2D
class_name ParallaxBackprop

@export var theme: ParallaxTheme:
	set(value):
		theme = value
		if is_node_ready():
			_apply_theme()

@onready var background: Parallax2D = $Background
@onready var weather: Parallax2D = $Weather
@onready var landscape: Parallax2D = $Landscape



func _ready() -> void:
	_apply_theme()

func _apply_theme() -> void:
	if theme == null:
		return

	var screen_center: Vector2 = get_viewport_rect().size / 2.0
	var spawn_origin: Vector2 = screen_center

	_clear_layer_children(background)
	_clear_layer_children(weather)
	_clear_layer_children(landscape)

	_set_layer(background, theme.background, theme.background_scale, spawn_origin)
	var weather_offset = spawn_origin + Vector2(0, 200)
	_set_layer(weather, theme.weather, theme.weather_scale, weather_offset)
	
	_set_layer(landscape, theme.landscape, theme.landscape_scale, spawn_origin)


func _set_layer(layer: Parallax2D, tex: Texture2D, scroll: Vector2, at: Vector2) -> void:
	layer.visible = tex != null
	layer.scroll_scale = scroll
	if tex:
		var sprite := Sprite2D.new()
		sprite.texture = tex
		sprite.position = at
		layer.add_child(sprite)
		layer.repeat_size = Vector2(tex.get_width(), 0)

func _clear_layer_children(layer: Parallax2D) -> void:
	if layer == null: return
	for child in layer.get_children():
		if child is Sprite2D:
			child.queue_free()
