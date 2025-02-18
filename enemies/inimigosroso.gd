extends "res://enemies/enemies.gd"

@onready var states: Node = $States


@onready var move_d_state: TimedStateComponent = %MoveDState as TimedStateComponent
@onready var move_side_state: TimedStateComponent = %MoveSideState as TimedStateComponent
@onready var pause_state: TimedStateComponent = %PauseState as TimedStateComponent
@onready var moveside_component: MoveComponent = %MovesideComponent as MoveComponent
@onready var spawner_componentdostiro: SpawnerComponent = %SpawnerComponentdostiro as SpawnerComponent
@onready var fire_state: StateComponent = %FireState as StateComponent

func _ready() -> void:
	super()
	
	for state in states.get_children():
		state = state as StateComponent
		state.disable()
		
	moveside_component.velocity.x = [-20, 20].pick_random()
	
	move_d_state.state_finished.connect(move_side_state.enable)
	move_side_state.state_finished.connect(func():
		fire_state.enable()
		scale_component.tween_scale()
		spawner_componentdostiro.spawn(global_position)
		fire_state.disable()
		fire_state.state_finished.emit()
		)
	fire_state.state_finished.connect(pause_state.enable)
	pause_state.state_finished.connect(move_d_state.enable)
	
	
	move_d_state.enable()
