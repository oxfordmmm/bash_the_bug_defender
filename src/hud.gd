extends CanvasLayer


var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset()

func _process(_delta: float) -> void:
	# update bars based on spawner
	update_res_bars()

func update_res_bars() -> void:
	if get_node("%BugSpawner"):
		var res = get_node("%BugSpawner").resistance_rates

		$%ResBars/Red.value = res[game_enums.AntibioticTypes.RED]
		$%ResBars/Green.value = res[game_enums.AntibioticTypes.GREEN]
		$%ResBars/Blue.value = res[game_enums.AntibioticTypes.BLUE]

func reset():
	score = 0
	$ScoreLabel.text = str(score)
	$ScoreLabel.show()
	

func add_score():
	score += 1
	$ScoreLabel.text = str(score)
	$ScoreLabel.show()
