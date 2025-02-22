class_name AnimatedOverlay
extends MarginContainer


@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
var control_parent : Control

@export var pos_offset : Vector2 = Vector2.ZERO

@export var enable_animation : bool = false:
    set = set_enable_anim

# ====== INITIALIZATION ====== #

func _ready() -> void:
    control_parent = get_parent() as Control
    # ---
    if enable_animation:
        control_parent.mouse_entered.connect(play_animation)
        control_parent.mouse_exited .connect(set_to_default)
    # ---
    control_parent.resized.connect(set_aspect_to_center)
    return

# ====== PROCESS ====== #

func set_aspect_to_center()->void:
    #var frame_size := animated_sprite_2d.sprite_frames.get_frame_texture("default",0).get_size()
    animated_sprite_2d.position = control_parent.size/2. + pos_offset
    return

# ====== MANAGEMENT ====== #

func set_enable_anim(value):
    if value!=enable_animation:
        if value:
            control_parent.mouse_entered.connect(play_animation)
            control_parent.mouse_exited .connect(set_to_default)
        else:
            control_parent.mouse_entered.disconnect(play_animation)
            control_parent.mouse_exited .disconnect(set_to_default)
    # ---
    enable_animation = value
    return

func play_animation()->void:
    animated_sprite_2d.play("swipe_clean")
    return

func set_to_default()->void:
    animated_sprite_2d.play("default")
    return
