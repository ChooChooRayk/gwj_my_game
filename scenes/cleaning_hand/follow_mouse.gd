class_name FollowMouse
extends Node

var parent : Node
var parent_size := Vector2.ZERO
var follow_mouse_enable : bool = false:
    set = set_follow_enable

@export var center_parent := true

# ====== INITIALIZATION ====== #

func _ready() -> void:
    parent = get_parent()
    set_process(false)

# ====== PROCESS ====== #

func _process(_delta: float) -> void:
    parent.global_position = parent.get_global_mouse_position()
    if center_parent:
        parent.global_position -= parent_size/2.
# ====== MANAGEMENT ====== #

func set_follow_enable(value)->void:
    if is_instance_valid(parent) and (parent.get("global_position")!=null):
        if parent.get("size")!=null:
            parent_size = parent.size
        set_process(value)
        follow_mouse_enable = value
    else:
        push_warning("parent is not conform for FollowMouse")
