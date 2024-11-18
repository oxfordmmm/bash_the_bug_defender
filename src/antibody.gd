extends Area2D

@export var speed: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta):
	position += transform.x * speed * delta

func initialize(start_pos: Vector2, dir: Vector2):
	position = start_pos
	look_at(to_global(dir))


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node) -> void:
	queue_free()
	body.take_dmg(1)
