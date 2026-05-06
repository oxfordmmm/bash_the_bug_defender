extends CanvasLayer

@export var score_row_scene: PackedScene
@export var score_row_color_normal: Color
@export var score_row_color_new_score: Color
@export var max_scores_shown: int = 8

func show_scores() -> void:
	var scores = Global.scores.duplicate(true)

	var display_scores = []
	for i in scores.size():
		var s = scores[i]
		display_scores.append([s[0], s[1], s[2], i == scores.size() - 1]) # name, diff, score, is_new_score

	display_scores.sort_custom(func(a, b): 
		if a[2] == b[2]: # if scores are equal, sort by name
			return b[0] > a[0]
		return b[2] < a[2] # Sort by score descending
	)

	var ranked_scores = []
	var current_score = null
	var current_rank = 0
	for s in display_scores:
		if s[2] != current_score:
			current_rank += 1
			current_score = s[2]
		ranked_scores.append([s[0], s[1], s[2], s[3], current_rank]) # name, diff, score, is_new_score, rank
	
	ranked_scores.sort_custom(func(a, b):
		if a[3]: # if a is new score, it should come first
			return true
		elif b[3]: # if b is new score, it should come first
			return false
		elif a[4] == b[4]: # if ranks are equal, sort by name
			return b[0] > a[0]
		else: # otherwise sort by rank
			return a[4] < b[4]
	)
	ranked_scores = ranked_scores.slice(0, max_scores_shown)
	ranked_scores.sort_custom(func(a, b):
		if a[4] == b[4]: # if ranks are equal, sort by name
			return b[0] > a[0]
		return a[4] < b[4] # sort by rank ascending
	)


	var container = $ColorRect/ScoresContainer
	# Clear existing rows    
	for child in container.get_children():
		child.queue_free()
	
	for s in ranked_scores:
		var row = score_row_scene.instantiate()
		row.get_node("Name").text = s[0]
		row.get_node("Position").text = str(s[4])
		row.get_node("Score").text = str(s[2])
		# change bg color if this is the new score
		var style = row.get_theme_stylebox("panel")
		style = style.duplicate()
		style.bg_color = score_row_color_new_score if s[3] else score_row_color_normal
		row.add_theme_stylebox_override("panel", style)

		container.add_child(row)

	set_visible(true)

func reset():
	set_visible(false)
