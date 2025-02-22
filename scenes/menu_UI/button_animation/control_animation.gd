class_name ControlAnimation
extends Node

@export var duration    : float = 1. # [s]
@export var autostart   := true
@export var start_delay : float = 0. # [s]
@export_category("Parameters")
@export var transition : Tween.TransitionType
@export var easing     : Tween.EaseType
@export var start_pos  : Vector2 = Vector2.ZERO

var tween       : Tween
var parent_ctrl : Control

# ====== INITIALIZATION ====== #

func _ready() -> void:
    parent_ctrl = get_parent() as Control
    if not(is_instance_valid(parent_ctrl)):
        queue_free()
    # ---
    if autostart:
        call_deferred("play_animation")

# ====== MANAGEMENT ====== #

func play_animation()->void:
    tween = get_tree().create_tween()
    tween.set_trans(Tween.TransitionType.TRANS_CUBIC)
    tween.set_ease (Tween.EaseType.EASE_OUT)
    # ---
    tween.tween_property(
        parent_ctrl, "position", parent_ctrl.position, duration
        ).from(parent_ctrl.position+start_pos)
        #.set_trans(Tween.TransitionType.TRANS_CUBIC
        #).set_ease (Tween.EaseType.EASE_OUT
        #)
    tween.finished.connect(end_animation_func)
    # ---
    tween.play()

func end_animation_func()->void:
    return
