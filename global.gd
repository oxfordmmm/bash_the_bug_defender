extends Node
var player_name := "Player name"
var difficulty: int
var speed = 30
var initial_spawn_rate = 0.4
var spawn_rate_acceleration = 0.02
var initial_resistance_rate = 0
var misuse_res_contribution = 0.04
var res_contribution = 0.01
var avatar_index: int

var avatars: Array[Texture2D] = []

var scores: Array = [] # (name, difficulty, score)
const SCORE_FILE_NAME := "bash_the_bug_scores.csv"

func _ready():
	# Randomise avatar when game starts
	avatars = _load_avatars("res://art/avatars")
	Global.avatar_index = randi_range(0, avatars.size() - 1)
	scores = load_scores()

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

func record_score(score: int):
	scores.append([player_name, difficulty, score])
	save_scores()

func get_score_file_path() -> String:
	var desktop_path := OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)
	if desktop_path.is_empty():
		# Fallback if the platform doesn't provide a desktop folder.
		return "user://highscores.json"
	return desktop_path.path_join(SCORE_FILE_NAME)

func save_scores() -> void:
	var file := FileAccess.open(get_score_file_path(), FileAccess.WRITE)
	if file == null:
		push_error("Failed to open file for writing")
		return

	file.store_string("Name,Difficulty,Score\n") # Header
	for s in scores:
		# Basic CSV line
		var line = "%s,%d,%d\n" % [s[0], s[1], s[2]]
		file.store_string(line)

func load_scores() -> Array:
	var result: Array = []

	var path := get_score_file_path()
	if not FileAccess.file_exists(path):
		return result

	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Failed to open file for reading")
		return result

	while not file.eof_reached():
		var line := file.get_line().strip_edges()
		if line.is_empty():
			continue
		
		if line.begins_with("Name,Difficulty,Score"):
			continue # Skip header

		var parts := line.split(",")

		if parts.size() != 3:
			continue # skip bad lines

		result.append([parts[0], int(parts[1]), int(parts[2])])

	return result
