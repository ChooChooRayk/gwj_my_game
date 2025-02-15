class_name BodyMotor
extends CharacterBody2D



const SPEED         = 300.0
const JUMP_VELOCITY = -400.0

var movement_direction : Vector2 = Vector2.ZERO

# ====== INITIALIZATION =====+ #

# ====== PROCESS =====+ #

func _physics_process(delta: float) -> void:
    if movement_direction:
        velocity = movement_direction * SPEED
    else:
        velocity = lerp(velocity, Vector2.ZERO, SPEED*delta/10.)
    # ---
    move_and_slide()
