extends Control

const SAVE_PATH = "user://save.cfg"
const TEST_SAVE_PATH = "res://save.cfg"

@export var game_status: GameStats

var save_path = TEST_SAVE_PATH
@onready var score_value: Label = %ScoreValue
@onready var high_score_value: Label = %HighScoreValue

func _ready() -> void:
	load_highscore()
	if game_status.score > game_status.highscore:
		game_status.highscore = game_status.score
		save_highscore()
	score_value.text = str(game_status.score)
	high_score_value.text = str(game_status.highscore)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		game_status.score = 0
		get_tree().change_scene_to_file("res://menu/menu.tscn")
		
		
func load_highscore():
	var config = ConfigFile.new()
	var error = config.load(save_path)
	if error != OK: return
	game_status.highscore = config.get_value("game", "highscore")
	
func save_highscore() -> void:
	var config = ConfigFile.new()
	config.set_value("game", "highscore", game_status.highscore)
	config.save(save_path ) 
