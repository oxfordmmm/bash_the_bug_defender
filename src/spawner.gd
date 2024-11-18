extends Node

@export var spawn_centre: Marker2D
@export var spawn_distance: float
@export var bug_scene: PackedScene

@export var initial_rate: float = 1
@export var spawn_acceleration: float = 0.1 # per second
var rate = 1

# y inverted for some reason
var DIRECTIONS = [
	Vector2(0, -1),
	Vector2(0, 1),
	Vector2(1, 0),
	Vector2(-1, 0),
	Vector2(1, -1),
	Vector2(-1, -1),
	Vector2(1, 1),
	Vector2(-1, 1),
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func begin_spawning():
	rate = initial_rate
	$SpawnTimer.wait_time = 1/rate
	$SpawnTimer.start()
	$AccelerationTimer.start()

func speed_up():
	rate += spawn_acceleration
	$SpawnTimer.wait_time = 1/rate

func spawn():
	var bug: Node2D = bug_scene.instantiate()
	var dir: Vector2 = DIRECTIONS.pick_random()
	bug.initialize(spawn_centre.position + dir * spawn_distance, spawn_centre.position)
	get_tree().root.add_child(bug)
