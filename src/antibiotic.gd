extends Area2D

@export var speed: int

@export var type: game_enums.AntibioticTypes

@export var colour_red: Color
@export var colour_blue: Color
@export var colour_green: Color
var colours: Dictionary
@export var icon_red: Resource
@export var icon_blue: Resource
@export var icon_green: Resource
var icons: Dictionary

@export var res_contribution: float
@export var misuse_res_contribution: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_visuals()

func _physics_process(delta):
	position += transform.x * speed * delta

func initialize(start_pos: Vector2, dir: Vector2, colour: game_enums.AntibioticTypes):
	type = colour
	position = start_pos
	look_at(to_global(dir))
	update_visuals()

func update_visuals():
	colours = {
		game_enums.AntibioticTypes.RED: colour_red,
		game_enums.AntibioticTypes.BLUE: colour_blue,
		game_enums.AntibioticTypes.GREEN: colour_green,
	}
	icons = {
		game_enums.AntibioticTypes.RED: icon_red,
		game_enums.AntibioticTypes.BLUE: icon_blue,
		game_enums.AntibioticTypes.GREEN: icon_green,
	}
	$Sprite2D/Cover.self_modulate = colours[type]
	$Sprite2D/Symbol.texture = icons[type]

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	get_tree().root.get_node("Main/BugSpawner").increase_resistance(type, Global.misuse_res_contribution)
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	get_tree().root.get_node("Main/BugSpawner").increase_resistance(type, Global.res_contribution)
	area.take_dmg(1, type)
	queue_free()
