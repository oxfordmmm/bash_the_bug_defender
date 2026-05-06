extends Node

@export var player_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene_to_file("res://scenes/splash_screen.tscn")

func start_game():
	$PlayerPos/Player.reset()
	get_tree().call_group("bugs", "queue_free")
	$BugSpawner.begin_spawning()
	$HUD.reset()
	$HighScores.reset()
	
func end_game():
	$BugSpawner.stop_spawning()
	$HUD.show_result()
	Global.record_score($HUD.score)

	# wait 3 seconds
	await get_tree().create_timer(3).timeout
	$HighScores.show_scores()
