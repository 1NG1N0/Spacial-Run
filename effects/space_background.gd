extends ParallaxBackground

@onready var space_layer: ParallaxLayer = %SpaceLayer
@onready var far_stars_layer: ParallaxLayer = %FarStarsLayer
@onready var close_stars_layer: ParallaxLayer = %CloseStarsLayer


func _process(delta: float) -> void:
	far_stars_layer.motion_offset.y += 15 * delta
	close_stars_layer.motion_offset.y += 20 * delta
	space_layer.motion_offset.y += 5 * delta
	pass
