extends TextureRect

func _ready():	
	Global.change_avatar($avatar_sprite, 0)
	$NameSetter.text = Global.player_name
	$DifficultyButton.select(Global.difficulty)

func _on_button_pressed() -> void:
	var difficulty = get_node("DifficultyButton").get_selected_id()
	match difficulty:
		0:
			Global.difficulty = 0
			Global.speed = 40
			Global.initial_spawn_rate = 0.4
			Global.spawn_rate_acceleration = 0.007
			Global.initial_resistance_rate = 0
			Global.res_contribution = 0.0
			Global.misuse_res_contribution = 0.0
		1:
			Global.difficulty = 0
			Global.speed = 45
			Global.initial_spawn_rate = 0.4
			Global.spawn_rate_acceleration = 0.01
			Global.initial_resistance_rate = 0
			Global.res_contribution = 0.03
			Global.misuse_res_contribution = 0.06
		2:
			Global.difficulty = 1
			Global.speed = 75
			Global.initial_spawn_rate = 0.5
			Global.spawn_rate_acceleration = 0.015
			Global.initial_resistance_rate = 0.15
			Global.res_contribution = 0.04
			Global.misuse_res_contribution = 0.1
		3:
			Global.difficulty = 2
			Global.speed = 105
			Global.initial_spawn_rate = 0.6
			Global.spawn_rate_acceleration = 0.03
			Global.initial_resistance_rate = 0.25
			Global.res_contribution = 0.05
			Global.misuse_res_contribution = 0.15
	get_tree().change_scene_to_file("res://scenes/single_player.tscn")


func _change_avatar_left() -> void:
	Global.change_avatar($avatar_sprite, -1)

func _change_avatar_right() -> void:
	Global.change_avatar($avatar_sprite, 1)


func _player_name_changed(text) -> void:
	Global.player_name = text
