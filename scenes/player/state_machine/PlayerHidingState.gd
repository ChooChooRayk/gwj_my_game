class_name PlayerHidingState
extends PlayerState

@export var hiding_sprite_frame : SpriteFrames

# ====== INITIALIZATION ====== #

func _ready() -> void:
    super()
    # ---
    EventBus.PlayerHidingFailed.connect(hiding_failed)

# ====== MANAGEMENT ====== #

func _process(_delta: float) -> void:
    if input_player.player_body.movement_direction:
        stop_hiding()

# ====== MANAGEMENT ====== #

func enter()->void:
    print("enter hiding state")
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

func hiding_failed()->void:
    var found_out_key := "hiding_found_out"
    if input_player.player_body.animated_sprite_2d.sprite_frames.has_animation(found_out_key):
        print("play finding out")
        print(input_player.player_body.animated_sprite_2d.sprite_frames.get_frame_duration(found_out_key,0))
        input_player.player_body.animated_sprite_2d.play(found_out_key)
        await input_player.player_body.animated_sprite_2d.animation_finished
    # ---
    print("stop hiding")
    call_deferred("stop_hiding")
    return
