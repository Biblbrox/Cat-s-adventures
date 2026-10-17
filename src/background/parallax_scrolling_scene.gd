@tool
extends Node2D
class_name ParallaxBackprop


@export var weather_spawn_center: Marker2D = Marker2D.new()
@export var background_spawn_center: Marker2D = Marker2D.new()
@export var landscape_spawn_center: Marker2D = Marker2D.new()

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

	_set_layer(background, theme.background, theme.background_scale, background_spawn_center.global_position)
	_set_layer(weather, theme.weather, theme.weather_scale, weather_spawn_center.global_position)
	_set_layer(landscape, theme.landscape, theme.landscape_scale, landscape_spawn_center.global_position)

func _set_layer(layer: Parallax2D, tex: Texture2D, scroll: Vector2, at: Vector2) -> void:
	layer.visible = tex != null
	layer.scroll_scale = scroll
	var sprite := Sprite2D.new()
	sprite.texture = tex
	sprite.position = at
	layer.add_child(sprite)
	if tex:
		layer.repeat_size = Vector2(tex.get_width(), 0)
