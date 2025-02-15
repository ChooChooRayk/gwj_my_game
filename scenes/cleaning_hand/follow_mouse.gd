class_name FollowMouse
extends Node

var parent : Node2D
var follow_mouse_enable : bool = false:
    set = set_follow_enable

# ====== INITIALIZATION ====== #

func _ready() -> void:
    parent = get_parent()
    set_process(false)

# ====== PROCESS ====== #

func _process(_delta: float) -> void:
    parent.global_position = parent.get_global_mouse_position()

# ====== MANAGEMENT ====== #

func set_follow_enable(value)->void:
    set_process(value)
    follow_mouse_enable = value
