extends Area2D

signal died

var speed: int
@export var health: int
@export var dmg: int

@export var colour_red: Color
@export var colour_blue: Color
@export var colour_green: Color
var colours: Dictionary
@export var icon_red: Resource
@export var icon_blue: Resource
@export var icon_green: Resource
var icons: Dictionary


var resistances: Array[game_enums.AntibioticTypes]

func _ready():
	var hud = get_tree().root.get_node("Main/HUD")
	speed = Global.speed
	if hud:
		died.connect(hud.add_score)

func _physics_process(delta):
	position += transform.x * speed * delta

func initialize(start_pos: Vector2, player_pos: Vector2, res: Array[game_enums.AntibioticTypes]):
	resistances = res
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
	set_colours()
	$Sprite.animation = "alive"
	
	position = start_pos
	look_at(player_pos)

func set_colours():	
	if len(resistances) == 0:
		$Shields.visible = false
	elif len(resistances) == 1:
		$Shields.visible = true
		$Shields/Centre.visible = true
		$Shields/Top.visible = false
		$Shields/Bottom.visible = false
		$Shields/Centre.modulate = colours[resistances[0]]
		$Shields/Centre.texture = icons[resistances[0]]
	else:
		$Shields.visible = true
		$Shields/Centre.visible = false
		$Shields/Top.visible = true
		$Shields/Bottom.visible = true
		$Shields/Top.modulate = colours[resistances[0]]
		$Shields/Bottom.modulate = colours[resistances[1]]
		$Shields/Top.texture = icons[resistances[0]]
		$Shields/Bottom.texture = icons[resistances[1]]

func die():
	$Sprite.animation = "dead"
	$Sprite.scale = Vector2(1.5, 1.5)
	speed = 0
	$CollisionShape2D.set_deferred("disabled", true)
	died.emit()
	
	await get_tree().create_timer(0.2).timeout
	queue_free()

func take_dmg(amount: int, color: game_enums.AntibioticTypes):
	if resistances.has(color):
		return
	
	health -= amount
	if health <= 0:
		die()


func _on_area_2d_area_entered(area: Area2D) -> void:
	print(area.get_groups())
	area.take_dmg(dmg)
	queue_free()


func _on_died() -> void:
	$SoundBugDied.play()
