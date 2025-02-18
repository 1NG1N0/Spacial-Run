extends Node2D

@export var greennenemyscene: PackedScene
@export var yellowenemy: PackedScene
@export var pinkenemy: PackedScene

@export var game_stats: GameStats

var margin = 8
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")
@onready var spawner_component: SpawnerComponent = $SpawnerComponent as SpawnerComponent
@onready var green_e_spawn_timer: Timer = $GreenESpawnTimer
@onready var yellow_timer: Timer = $YellowTimer
@onready var pink_timer: Timer = $PinkTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	green_e_spawn_timer.timeout.connect(handle_spawn.bind(greennenemyscene, green_e_spawn_timer))
	yellow_timer.timeout.connect(handle_spawn.bind(yellowenemy, yellow_timer))
	pink_timer.timeout.connect(handle_spawn.bind(pinkenemy, pink_timer))
	game_stats.score_changed.connect(func(new_score: int):
		if new_score > 10:
			yellow_timer.process_mode = Node.PROCESS_MODE_INHERIT
		if new_score > 50:
			pink_timer.process_mode = Node.PROCESS_MODE_INHERIT
		)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func handle_spawn(enemy_type: PackedScene, timer: Timer, time_offset: float = 1.0) -> void:
	spawner_component.scene = enemy_type
	spawner_component.spawn(Vector2(randf_range(margin, screen_width-margin), -16))
	var spawn_rate = time_offset / (0.5 + (game_stats.score * 0.01))
	timer.start(spawn_rate + randf_range(0.35, 0.6))
