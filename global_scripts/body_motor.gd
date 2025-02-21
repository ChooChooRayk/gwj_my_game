class_name BodyMotor
extends CharacterBody2D



var SPEED         = 300.0

var movement_direction : Vector2 = Vector2.ZERO
@onready var foot_position: Marker2D = %FootPosition

var animated_sprite_2d: AnimatedSprite2D
var last_direction := Vector2.UP

# ====== INITIALIZATION =====+ #

func _ready() -> void:
    animated_sprite_2d = Utilities.find_first_child_of_type(self, AnimatedSprite2D) as AnimatedSprite2D

# ====== PROCESS =====+ #

func _physics_process(delta: float) -> void:
    if movement_direction:
        velocity       = movement_direction * SPEED
        last_direction = movement_direction.normalized()
    else:
        velocity = lerp(velocity, Vector2.ZERO, delta * SPEED/10.)
    # ---
    manage_animation()
    move_and_slide()
    #print("velocity : ", velocity.length())

# ====== MANAGEMENT =====+ #

func manage_animation()->void:
    var anim_dir  = ""
    var anim_type = ""
    # ---
    if is_instance_valid(animated_sprite_2d):
        if movement_direction:
            anim_type = "walk"
        else:
            anim_type = "idle"
        # ---
        if   (last_direction.x>last_direction.y) and (last_direction.x>-last_direction.y):
            anim_dir = "left"
            animated_sprite_2d.flip_h = true
        elif (last_direction.x<last_direction.y) and (last_direction.x>-last_direction.y):
            anim_dir = "down"
            animated_sprite_2d.flip_h = false
        elif (last_direction.x<last_direction.y) and (last_direction.x<-last_direction.y):
            anim_dir = "left"
            animated_sprite_2d.flip_h = false
        elif (last_direction.x>last_direction.y) and (last_direction.x<-last_direction.y):
            anim_dir = "up"
            animated_sprite_2d.flip_h = false
        else:
            anim_dir = "down"
            animated_sprite_2d.flip_h = false            
        # ---
        animated_sprite_2d.play("{type}_{dir}".format({"type":anim_type, "dir":anim_dir}))
    return
