extends Node

# Character list. They can be either player or a mob in the current scene
# For example, if the dog is a player now, it should be spawned by register_player. 
# Otherwise, with spawn_character
const CHARACTERS := {
	&"dog": preload("res://data/characters/dog.tres"),
	&"cat": preload("res://data/characters/cat.tres"),
}

var characters: Dictionary = {}       # id -> spawned character


func spawn_character(id: StringName, parent: Node, at: Vector2, playable: bool = false) -> Node2D:
	var def: CharacterDef = CHARACTERS[id]
	var c: Player = def.scene.instantiate()
	parent.add_child(c)
	parent.move_child(c, 0)
	c.global_position = at
	characters[id] = c
	c.tree_exiting.connect(_on_character_exiting.bind(id, c))
	
	c.start(at)
	c.set_physics_process(true)
	c.freeze()
	if playable:
		c.unfreeze()

	return c

func _on_character_exiting(id: StringName, c: Node) -> void:
	if characters.get(id) == c:
		characters.erase(id)
