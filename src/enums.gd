extends Node

class_name game_enums
enum AntibioticTypes {RED, GREEN, BLUE}

const string_to_colour = {
	"red": game_enums.AntibioticTypes.RED,
	"blue": game_enums.AntibioticTypes.BLUE,
	"green": game_enums.AntibioticTypes.GREEN,
}

const colour_to_string = {
	game_enums.AntibioticTypes.RED: "red",
	game_enums.AntibioticTypes.BLUE: "blue",
	game_enums.AntibioticTypes.GREEN: "green",
}
