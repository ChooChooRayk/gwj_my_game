class_name PlayerHidingState
extends PlayerState

@export var hiding_sprite_frame : SpriteFrames

# ====== INITIALIZATION ====== #

func _ready() -> void:
    super()

# ====== MANAGEMENT ====== #

func enter()->void:
    if not(is_instance_valid(hiding_sprite_frame)):
        push_error("not hiding frame set !")
        return
    # ---
    input_player.player_body.animated_sprite_2d.sprite_frames = hiding_sprite_frame
    return
    
func exit()->void:
    return
