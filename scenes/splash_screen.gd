extends TextureRect

func _on_button_pressed() -> void:
	var difficulty = get_node("DifficultyButton").get_selected_id()
	match difficulty:
		0:
			Global.speed = 10
		1:
			Global.speed = 90
		2:
			Global.speed = 120
	get_tree().change_scene_to_file("res://scenes/single_player.tscn")
