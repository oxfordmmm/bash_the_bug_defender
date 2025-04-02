extends Node2D

signal hit
signal died

@export var starting_health: int = 3
@export var antibiotic_scene: PackedScene
@export var antibiotic_colour: game_enums.AntibioticTypes = game_enums.AntibioticTypes.RED
var health: int

# y inverted for some reason
var INPUT_DIR_MAPPING = {
		"N" : Vector2(0, -1),
		#"S" : Vector2(0, 1),
		"E" : Vector2(1, 0),
		"W" : Vector2(-1, 0),
		"NE" : Vector2(1, -1),
		"NW" : Vector2(-1, -1),
		#"SE" : Vector2(1, 1),
		#"SW" : Vector2(-1, 1)
	}

func reset():
	health = starting_health
	$CollisionShape2D.set_deferred("disabled", false)
	$AnimatedSprite2D.set("visible", true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health < 0:
		return
	for input in INPUT_DIR_MAPPING:
		if Input.is_action_just_pressed(input):
			fire_antibiotic(INPUT_DIR_MAPPING[input])

func fire_antibiotic(dir: Vector2) -> void:
	var antibiotic = antibiotic_scene.instantiate()
	antibiotic.initialize(to_global(position) + dir * 50, dir, antibiotic_colour)
	get_tree().root.add_child(antibiotic)

func die():
	died.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite2D.set("visible", false)

func take_dmg(amount: int):
	health -= amount
	hit.emit()
	if health <= 0:
		die()
		return
		
func set_antibiotic_color(colour: String):
	antibiotic_colour = game_enums.string_to_colour[colour]


func _on_hit() -> void:
	$SoundHit.play()
