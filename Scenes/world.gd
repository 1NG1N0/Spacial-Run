extends Node2D

@export var game_stats: GameStats
@onready var ship: Node2D = $Ship
@onready var score_label: Label = $ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	game_stats.score_changed.connect(update_score_label)
	ship.tree_exited.connect(func():
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://menu/game_over.tscn")
		)


func update_score_label(new_score: int) -> void:
	score_label.text = "score: " + str(new_score)
