class_name PlayerNormalState
extends PlayerState


@export var normal_sprite_frame : SpriteFrames

# ====== INITIALIZATION ====== #

func _ready() -> void:
    super()
    # ---
    if not(is_instance_valid(normal_sprite_frame)):
        normal_sprite_frame = input_player.player_body.animated_sprite_2d.sprite_frames
    # ---
    EventBus.PlayerHidingRequested.connect(set_hiding_outfit)
    
# ====== MANAGEMENT ====== #

func enter()->void:
    print("player state : player body ", input_player.player_body.animated_sprite_2d)
    if is_instance_valid(input_player.player_body.animated_sprite_2d):
        input_player.player_body.animated_sprite_2d.sprite_frames = normal_sprite_frame
    return
    
func exit()->void:
    return

func set_hiding_outfit()->void:
    ChangeStateRequested.emit(self, STATES.Hiding)
    return
