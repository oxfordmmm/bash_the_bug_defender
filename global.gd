extends Node
var speed = 30
var initial_spawn_rate = 0.4
var spawn_rate_acceleration = 0.02
var initial_resistance_rate = 0
var misuse_res_contribution = 0.04
var res_contribution = 0.01
var avatar_index: int

var avatars = [
	load("res://art/avatars/angry_pasteur.svg"),
	load("res://art/avatars/circle_avatar.svg"),
	load("res://art/avatars/generic_doctor.svg")
	]

func _ready():
	# Randomise avatar when game starts
	Global.avatar_index = randi_range(0, avatars.size() - 1)
