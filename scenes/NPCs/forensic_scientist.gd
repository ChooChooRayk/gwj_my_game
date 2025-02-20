class_name ForensicScientist
extends CharacterBody2D

enum DIRECTION_TYPE {UP,DOWN,LEFT,RIGHT}
@export var idle_direction : DIRECTION_TYPE
@export var change_behaviour_time :float = 2. # [s]
@export var is_inspector := false

var behaviour_timer : Timer
var rng := RandomNumberGenerator.new()
var animation_sprite_2d : AnimatedSprite2D

var dir_dic := {
    DIRECTION_TYPE.UP    : "up",
    DIRECTION_TYPE.DOWN  : "down",
    DIRECTION_TYPE.LEFT  : "left",
    DIRECTION_TYPE.RIGHT : "right",
}

# ====== INITIALIZATION ====== #

func _ready() -> void:
    animation_sprite_2d = Utilities.find_first_child_of_type(self, AnimatedSprite2D) as AnimatedSprite2D
    # ---
    behaviour_timer = Timer.new()
    behaviour_timer.wait_time = change_behaviour_time
    behaviour_timer.one_shot  = true
    behaviour_timer.autostart = true
    behaviour_timer.timeout.connect(change_behaviour)
    add_child(behaviour_timer)
    # ---
    change_behaviour()
    return

# ====== MANAGEMENT ====== #

func change_behaviour()->void:
    if not(is_instance_valid(animation_sprite_2d)):
        return
    # ---
    if rng.randf()<0.1:
        if is_inspector:
            animation_sprite_2d.play("reveal_down")
        else:
            animation_sprite_2d.play("searching_down")
    else:
        animation_sprite_2d.play("idle_{dir}".format({"dir":dir_dic[idle_direction]}))
    # ---
    await animation_sprite_2d.animation_finished
    #behaviour_timer.start()
    change_behaviour()
    return
