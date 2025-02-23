class_name PlayerHidingState
extends PlayerState

@export var hiding_sprite_frame : SpriteFrames

# ====== INITIALIZATION ====== #

func _ready() -> void:
    super()
    # ---
    set_process(false)

# ====== MANAGEMENT ====== #

func _process(_delta: float) -> void:
    if input_player.player_body.movement_direction:
        stop_hiding()
    # ---
    if is_discovered:
        hiding_failed()

# ====== MANAGEMENT ====== #

func enter()->void:
    super()
    if not(is_instance_valid(hiding_sprite_frame)):
        push_error("not hiding frame set !")
        return
    # ---
    input_player.set_player_frozen(true)
    input_player.player_body.movement_direction = Vector2.ZERO
    input_player.player_body.animated_sprite_2d.sprite_frames = hiding_sprite_frame
    # ---
    await get_tree().create_timer(0.2).timeout # to let the player react and stop moving
    input_player.set_player_frozen(false)
    # ---
    EventBus.PlayerHidden.emit()
    set_process(true)
    return
    
func exit()->void:
    super()
    set_process(false)
    is_discovered = false
    EventBus.PlayerHidingStopped.emit()
    return

func stop_hiding()->void:
    input_player.player_body.is_anim_managed = true
    #input_player.player_body.set_physics_process(true)
    ChangeStateRequested.emit(self, STATES.Normal)
    return

func hiding_failed()->void:
    set_process(false)
    # ---
    var found_out_key := "hiding_found_out"
    if input_player.player_body.animated_sprite_2d.sprite_frames.has_animation(found_out_key):
        input_player.player_body.is_anim_managed = false
        #input_player.player_body.set_physics_process(false)
        input_player.player_body.animated_sprite_2d.animation_finished.connect(stop_hiding)
        input_player.player_body.animated_sprite_2d.play(found_out_key)
    else:
        call_deferred("stop_hiding")
    return
