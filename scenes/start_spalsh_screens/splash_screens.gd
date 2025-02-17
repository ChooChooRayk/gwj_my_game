class_name SplashScreens
extends Control


@export var tween_trans : Tween.TransitionType
@export var tween_ease  : Tween.EaseType

@onready var splash_screen_intro_0: Control = $SplashScreenIntro0
@onready var splash_screen_intro_1: Control = $SplashScreenIntro1

@onready var trans_overlay: ColorRect = $TransOverlay
var color_on  : Color
var color_off : Color

var splash_scrn_list :Array[Control] = []
var screen_count     :int = 0

var tween : Tween
var trans_duration   := 1. # [s]
var display_duration := 3.0 # [s]

# ====== INITIALIZATION ====== #

func _ready() -> void:
    splash_scrn_list.append(splash_screen_intro_0)
    splash_scrn_list.append(splash_screen_intro_1)
    # ---
    for child in splash_scrn_list:
        child.visible = false
    # ---
    color_on      = Color(trans_overlay.color, 1.0)
    color_off     = Color(trans_overlay.color, 0.0)
    # ---
    next_scren()

# ====== PROCESS ====== #

func _input(event: InputEvent) -> void:
    if event.is_pressed():
        interupt_splash()
    return

# ====== MANAGEMENT ====== #

func fade_overlay(type:String)->void:
    tween = get_tree().create_tween()
    tween.set_trans(tween_trans)
    tween.set_ease (tween_ease )
    match type:
        "fade_in":
            tween.tween_property(trans_overlay, "color", color_off, trans_duration).from(color_on)
        "fade_out":
            tween.tween_property(trans_overlay, "color", color_on , trans_duration).from(color_off)
    tween.play()
    return

func next_scren()->void:
    if screen_count>=splash_scrn_list.size():
        fade_overlay("fade_in")
        await tween.finished
        queue_free()
        return
    # ---
    splash_scrn_list[screen_count].visible = true
    fade_overlay("fade_in")
    await tween.finished
    await get_tree().create_timer(display_duration).timeout
    fade_overlay("fade_out")
    await tween.finished
    splash_scrn_list[screen_count].visible = false
    # ---
    screen_count += 1
    next_scren()

func interupt_splash()->void:
    tween.kill()
    screen_count += 1
    if screen_count>=splash_scrn_list.size():
        queue_free()
        return
    next_scren()
    
