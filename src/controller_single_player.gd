extends Node

@export var player_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		start_game()

func start_game():
	$PlayerPos/Player.reset()
	get_tree().call_group("bugs", "queue_free")
	$Spawner.begin_spawning()
	$HUD.reset()
	
func end_game():
	$Spawner.stop_spawning()
