extends CanvasLayer


var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset()


func reset():
	score = 0
	$ScoreLabel.text = str(score)
	$ScoreLabel.show()
	

func add_score():
	score += 1
	$ScoreLabel.text = str(score)
	$ScoreLabel.show()
