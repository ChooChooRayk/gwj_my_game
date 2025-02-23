class_name SplashScreens
extends Control

signal SplashScreensFinished()

@export var tween_trans : Tween.TransitionType
@export var tween_ease  : Tween.EaseType
@export var trans_duration   := 0.5 # [s]
@export var display_duration := 2.0 # [s]

@onready var splash_screen_intro_0  : Control = $SplashScreenIntro0
@onready var splash_screen_intro_1  : Control = $SplashScreenIntro1
@onready var splash_content_warning : Control = $SplashContentWarning

@onready var trans_overlay: SceneTransitionOverlay = $SceneTransitionOverlay

var splash_scrn_list :Array[Control] = []
var screen_count     :int = 0

var tween : Tween

# ====== INITIALIZATION ====== #

func _ready() -> void:
    visible = true
    trans_overlay.transition_duration = trans_duration
    # ---
    splash_scrn_list.append(splash_screen_intro_0)
    splash_scrn_list.append(splash_screen_intro_1)
    splash_scrn_list.append(splash_content_warning)
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
    if trans_overlay.animation_player.is_playing():# tackle the asynchronicity
        await trans_overlay.animation_player.animation_finished
    # ---
    #print("splash screen count : ", screen_count)
    if screen_count>=splash_scrn_list.size():
        trans_overlay.transition(SceneTransitionOverlay.TRANS_TYPE.FADE_IN)
        await trans_overlay.transition_finished
        end_splash_screens()
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
    await next_scren()

func interupt_splash()->void:
    trans_overlay.skip_transition()
    screen_count += 1
    if screen_count>=splash_scrn_list.size():
        end_splash_screens()
        return
    await next_scren()

func end_splash_screens()->void:
        SplashScreensFinished.emit()
        queue_free()
