extends Node

func _ready() -> void:
	set_antibiotic_color("red")
	
## Horrible hack to pick up bottom right button press
func _input(event):
	if event is InputEventJoypadMotion:
		if (event.axis == 5):
			set_antibiotic_color("green")

func set_antibiotic_color(colour: String):
	print("Selected ", colour)
	$%Player.set_antibiotic_color(colour)
	
	var target_pos = Vector2.ZERO
	match colour:
		"red":
			target_pos = $Red/Antibiotic.global_position
		"blue":
			target_pos = $Blue/Antibiotic.global_position
		"green":
			target_pos = $Green/Antibiotic.global_position

	var tween = create_tween()
	tween.tween_property($Selector, "global_position", target_pos, 0.2)
