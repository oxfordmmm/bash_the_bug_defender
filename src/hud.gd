extends CanvasLayer


var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 0
	$ScoreLabel.text = str(score)
	$ScoreLabel.show()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_score():
	score += 1
	$ScoreLabel.text = str(score)
	$ScoreLabel.show()
