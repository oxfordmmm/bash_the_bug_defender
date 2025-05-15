extends TextureRect

func _on_button_pressed() -> void:
	var difficulty = get_node("DifficultyButton").get_selected_id()
	match difficulty:
		0:
			Global.speed = 45
			Global.initial_spawn_rate = 0.3
			Global.spawn_rate_acceleration = 0.015
		1:
			Global.speed = 90
			Global.initial_spawn_rate = 0.6
			Global.spawn_rate_acceleration = 0.03
		2:
			Global.speed = 120
			Global.initial_spawn_rate = 0.8
			Global.spawn_rate_acceleration = 0.03
	get_tree().change_scene_to_file("res://scenes/single_player.tscn")
