extends Node2D

signal hit
signal died

@export var health: int = 3
@export var antibody_scene: PackedScene

# y inverted for some reason
var INPUT_DIR_MAPPING = {
		"N" : Vector2(0, -1),
		"S" : Vector2(0, 1),
		"E" : Vector2(1, 0),
		"W" : Vector2(-1, 0),
		"NE" : Vector2(1, -1),
		"NW" : Vector2(-1, -1),
		"SE" : Vector2(1, 1),
		"SW" : Vector2(-1, 1)
	}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for input in INPUT_DIR_MAPPING:
		if Input.is_action_just_pressed(input):
			fire_antibody(INPUT_DIR_MAPPING[input])

func fire_antibody(dir: Vector2) -> void:
	var antibody = antibody_scene.instantiate()
	antibody.initialize(to_global(position) + dir * 50, dir)
	get_tree().root.add_child(antibody)

func die():
	died.emit()
	queue_free()

func take_dmg(amount: int):
	health -= amount
	hit.emit()
	if health <= 0:
		die()
		return
