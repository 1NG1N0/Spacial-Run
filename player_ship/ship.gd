extends Node2D
@onready var left_canon: Marker2D = $LeftCanon
@onready var rigth_canon: Marker2D = $RigthCanon
@onready var spawner_component: SpawnerComponent = $SpawnerComponent as SpawnerComponent
@onready var fire_rate_timer: Timer = $FireRateTimer
@onready var scale_component: ScaleComponent = $ScaleComponent as ScaleComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $Anchor/AnimatedSprite2D
@onready var move_component: MoveComponent = $MoveComponent
@onready var flame_animated_sprite: AnimatedSprite2D = %FlameAnimatedSprite
@onready var variable_pitch_audio_stream_player: VariablePitchAudioStreamPlayer = $VariablePitchAudioStreamPlayer




func _ready() -> void:
	fire_rate_timer.timeout.connect(fire_lasers)
	
	
	
func fire_lasers() -> void:
	variable_pitch_audio_stream_player.play_with_variance()
	spawner_component.spawn(left_canon.global_position)
	spawner_component.spawn(rigth_canon.global_position)
	scale_component.tween_scale()
	
	
	
func _process(delta: float) -> void:
	animate_the_Ship()

func animate_the_Ship():
	if move_component.velocity.x < 0:
		animated_sprite_2d.play("bank left")
		flame_animated_sprite.play("bank_left")
	elif move_component.velocity.x > 0:
		animated_sprite_2d.play("bank rigth")
		flame_animated_sprite.play("bank_rigth")
	else:
		animated_sprite_2d.play("Center")
		flame_animated_sprite.play("Center")
