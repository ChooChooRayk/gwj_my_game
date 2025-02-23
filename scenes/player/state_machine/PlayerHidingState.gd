class_name PlayerHidingState
extends PlayerState

@export var hiding_sprite_frame : SpriteFrames

# ====== INITIALIZATION ====== #

func _ready() -> void:
    super()

# ====== MANAGEMENT ====== #

func _process(delta: float) -> void:
    if input_player.player_body.movement_direction:
        stop_hiding()

# ====== MANAGEMENT ====== #

func enter()->void:
    if not(is_instance_valid(hiding_sprite_frame)):
        push_error("not hiding frame set !")
        return
    # ---
    input_player.set_player_frozen(true)
    input_player.player_body.movement_direction = Vector2.ZERO
    input_player.player_body.animated_sprite_2d.sprite_frames = hiding_sprite_frame
    # ---
    await get_tree().create_timer(0.5).timeout # to let the player react and stop moving
    input_player.set_player_frozen(false)
    # ---
    EventBus.PlayerHidden.emit()
    return
    
func exit()->void:
    return

func stop_hiding()->void:
    ChangeStateRequested.emit(self, STATES.Normal)
    return
