class_name SceneTransitionOverlay
extends CanvasLayer

enum TRANSITION_TYPE {FADE_IN, FADE_OUT}

@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func transition(trasn_type:TRANSITION_TYPE, duration:float=0.5)->void:
    var anim_key : String
    match animation_player:
        TRANSITION_TYPE.FADE_IN:
            anim_key = "fade_in"
        TRANSITION_TYPE.FADE_OUT:
            anim_key = "fade_out"
        _:
            anim_key = "fade_in"
    # ---
    animation_player.play(anim_key, -1.0, 1/duration)
