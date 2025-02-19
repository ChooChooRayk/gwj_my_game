class_name SceneTransitionOverlay
extends Control

enum TRANS_TYPE {FADE_IN, FADE_OUT}

signal transition_finished()
@export var transition_duration :float= 0.5
@export var init_visible : bool = false 


@onready var color_rect      : ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
    visible = true
    # ---
    animation_player.animation_finished.connect(func (_anim_name:String):transition_finished.emit())
    if init_visible:
        animation_player.play(&"STATE_VISIBLE")
    else:
        animation_player.play(&"STATE_HIDDEN")

func transition(trans_type:TRANS_TYPE, duration:float=transition_duration)->void:
    var anim_key : String
    match trans_type:
        TRANS_TYPE.FADE_IN:
            anim_key = "fade_in"
        TRANS_TYPE.FADE_OUT:
            anim_key = "fade_out"
        _:
            anim_key = "fade_in"
    # ---
    animation_player.play(anim_key, -1.0, 1/duration)

func skip_transition()->void:
    animation_player.stop()
    return
