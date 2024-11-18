extends RigidBody2D

signal died

@export var speed: int
@export var health: int
@export var dmg: int
@export var super_chance: float

func _ready():
	var hud = get_tree().root.get_node("Main/HUD")
	print(hud)
	if hud:
		print("adding score")
		died.connect(hud.add_score)

func initialize(start_pos: Vector2, player_pos: Vector2):
	$AnimatedSprite2D.animation = "alive"
	
	position = start_pos
	look_at(player_pos)
	linear_velocity = (player_pos - start_pos).normalized() * speed
	
	if randf() <= super_chance:
		health = 2
		$AnimatedSprite2D.animation = "super"

func die():
	$AnimatedSprite2D.animation = "dead"
	linear_velocity = Vector2.ZERO
	$CollisionShape2D.set_deferred("disabled", true)
	died.emit()
	
	await get_tree().create_timer(0.2).timeout
	queue_free()

func take_dmg(amount: float):
	health -= amount
	if health <= 0:
		die()


func _on_area_2d_area_entered(area: Area2D) -> void:
	queue_free()
	area.take_dmg(dmg)
