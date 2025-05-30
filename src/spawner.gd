extends Node

@export var spawn_centre: Marker2D
@export var spawn_distance: float
@export var bug_scene: PackedScene

var spawn_acceleration: float = 0.1 # per second
var spawn_rate = 1

@export var resistance_rates: Dictionary

# y inverted for some reason
var DIRECTIONS = [
	Vector2(0, -1),
	#Vector2(0, 1),
	Vector2(0.8, 0), # horizontal distance shorter than vertical (includes HUD area)
	Vector2(-0.8, 0),
	Vector2(0.9, -0.9), # diagonal distance slightly shorter than vertical
	Vector2(-0.9, -0.9),
	#Vector2(1, 1),
	#Vector2(-1, 1),
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_acceleration = Global.spawn_rate_acceleration


	
func begin_spawning():
	spawn_rate = Global.initial_spawn_rate
	resistance_rates = {
		game_enums.AntibioticTypes.RED: Global.initial_resistance_rate,
		game_enums.AntibioticTypes.BLUE: Global.initial_resistance_rate,
		game_enums.AntibioticTypes.GREEN: Global.initial_resistance_rate,
	}
	$SpawnTimer.wait_time = 1/spawn_rate
	$SpawnTimer.start()
	$AccelerationTimer.start()

func stop_spawning():
	$SpawnTimer.stop()
	$AccelerationTimer.stop()

func speed_up():
	spawn_rate += spawn_acceleration
	$SpawnTimer.wait_time = 1/spawn_rate

func increase_resistance(c: game_enums.AntibioticTypes, amount: float):
	print("increasing res by ", amount)
	print(resistance_rates[c])
	resistance_rates[c] = min(1, resistance_rates[c] + amount)
	print(resistance_rates[c])

func reduce_resistances():
	for c in resistance_rates:
		resistance_rates[c] = max(0, resistance_rates[c] - 0.01)

func spawn():
	var bug: Node2D = bug_scene.instantiate()
	var dir: Vector2 = DIRECTIONS.pick_random()
	
	var resistances: Array[game_enums.AntibioticTypes] = []
	for color in resistance_rates:
		if randf() < resistance_rates[color]:
			resistances.append(color)
	
	if len(resistances) > 2:
		print("removing")
		# need to remove one at random
		resistances.remove_at(randi() % 3)
	
	bug.initialize(spawn_centre.position + dir * spawn_distance, spawn_centre.position, resistances)
	get_tree().root.add_child(bug)
