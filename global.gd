extends Node
var speed = 30
var initial_spawn_rate = 0.4
var spawn_rate_acceleration = 0.02
var initial_resistance_rate = 0
var misuse_res_contribution = 0.04
var res_contribution = 0.01
var avatar_index: int

var avatars: Array[Texture2D] = []

func _ready():
	# Randomise avatar when game starts
	avatars = _load_avatars("res://art/avatars")
	Global.avatar_index = randi_range(0, avatars.size() - 1)

# Loads all avatar textures. Strangely clunky in gdscript
func _load_avatars(folder_path: String) -> Array[Texture2D]:
	var result: Array[Texture2D] = []
	var dir = DirAccess.open(folder_path)

	if dir == null:
		push_error("Could not open folder: %s" % folder_path)
		return result

	dir.list_dir_begin()
	var file_name = dir.get_next()

	while file_name != "":
		if not dir.current_is_dir():
			var ext = file_name.get_extension().to_lower()
			if ext in ["png", "svg", "jpg", "jpeg"]:
				var full_path = folder_path.path_join(file_name)
				result.append(load(full_path))
		file_name = dir.get_next()

	dir.list_dir_end()
	return result

func change_avatar(avatar_sprite: Sprite2D, change: int) -> void:
	Global.avatar_index = (Global.avatar_index + change + Global.avatars.size()) % Global.avatars.size()
	avatar_sprite.texture = Global.avatars[Global.avatar_index]

	var target_size = Vector2(120, 130)
	var texture_size = avatar_sprite.texture.get_size()

	var scale_factor = min(
		target_size.x / texture_size.x,
		target_size.y / texture_size.y
	)

	avatar_sprite.scale = Vector2.ONE * scale_factor
