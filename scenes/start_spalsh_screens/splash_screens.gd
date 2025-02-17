class_name SplashScreens
extends Control


@export var tween_trans : Tween.TransitionType
@export var tween_ease  : Tween.EaseType

@onready var splash_screen_intro_0: Control = $SplashScreenIntro0
@onready var splash_screen_intro_1: Control = $SplashScreenIntro1

@onready var trans_overlay: SceneTransitionOverlay = $SceneTransitionOverlay

var splash_scrn_list :Array[Control] = []
var screen_count     :int = 0

var tween : Tween
var trans_duration   := 1. # [s]
var display_duration := 3.0 # [s]

# ====== INITIALIZATION ====== #

func _ready() -> void:
    visible = true
    # ---
    splash_scrn_list.append(splash_screen_intro_0)
    splash_scrn_list.append(splash_screen_intro_1)
    # ---
    for child in splash_scrn_list:
        child.visible = false
    # ---
    next_scren()

# ====== PROCESS ====== #

func _input(event: InputEvent) -> void:
    if event.is_pressed():
        interupt_splash()
    return

# ====== MANAGEMENT ====== #

func next_scren()->void:
    if screen_count>=splash_scrn_list.size():
        trans_overlay.transition(SceneTransitionOverlay.TRANS_TYPE.FADE_IN)
        await trans_overlay.transition_finished
        queue_free()
        return
    # ---
    splash_scrn_list[screen_count].visible = true
    trans_overlay.transition(SceneTransitionOverlay.TRANS_TYPE.FADE_IN)
    await trans_overlay.transition_finished
    await get_tree().create_timer(display_duration).timeout
    trans_overlay.transition(SceneTransitionOverlay.TRANS_TYPE.FADE_OUT)
    await trans_overlay.transition_finished
    splash_scrn_list[screen_count].visible = false
    # ---
    screen_count += 1
    next_scren()

func interupt_splash()->void:
    trans_overlay.skip_transition()
    screen_count += 1
    if screen_count>=splash_scrn_list.size():
        queue_free()
        return
    next_scren()
    
