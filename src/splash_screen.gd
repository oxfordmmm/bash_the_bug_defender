extends TextureRect

func _ready():	
	$avatar_sprite.texture = Global.avatars[Global.avatar_index]

func _on_button_pressed() -> void:
	var difficulty = get_node("DifficultyButton").get_selected_id()
	match difficulty:
		0:
			Global.speed = 45
			Global.initial_spawn_rate = 0.4
			Global.spawn_rate_acceleration = 0.01
			Global.initial_resistance_rate = 0
			Global.res_contribution = 0.03
			Global.misuse_res_contribution = 0.06
		1:
			Global.speed = 75
			Global.initial_spawn_rate = 0.5
			Global.spawn_rate_acceleration = 0.015
			Global.initial_resistance_rate = 0.15
			Global.res_contribution = 0.04
			Global.misuse_res_contribution = 0.1
		2:
			Global.speed = 105
			Global.initial_spawn_rate = 0.6
			Global.spawn_rate_acceleration = 0.03
			Global.initial_resistance_rate = 0.25
			Global.res_contribution = 0.05
			Global.misuse_res_contribution = 0.15
	get_tree().change_scene_to_file("res://scenes/single_player.tscn")


func _on_pick_left_pressed() -> void:
	if Global.avatar_index - 1 >= 0:
		Global.avatar_index = Global.avatar_index - 1
	else:
		Global.avatar_index = Global.avatars.size() - 1
	$avatar_sprite.texture = Global.avatars[Global.avatar_index]

func _on_pick_right_pressed() -> void:
	if Global.avatar_index + 1 < Global.avatars.size():
		Global.avatar_index = Global.avatar_index + 1
	else:
		Global.avatar_index = 0
	$avatar_sprite.texture = Global.avatars[Global.avatar_index]
