class_name PlayerNormalState
extends PlayerState


@export var normal_sprite_frame : SpriteFrames

# ====== INITIALIZATION ====== #

func _ready() -> void:
    super()
    # ---
    if not(is_instance_valid(normal_sprite_frame)):
        normal_sprite_frame = input_player.player_body.animated_sprite_2d.sprite_frames

# ====== MANAGEMENT ====== #

func enter()->void:
    input_player.player_body.animated_sprite_2d.sprite_frames = normal_sprite_frame
    return
    
func exit()->void:
    return
