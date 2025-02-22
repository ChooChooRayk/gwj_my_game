class_name MainMenuAnimButton
extends ControlAnimation

@export var sprite_anim : AnimatedOverlay
@export var splash_screen : SplashScreens

# ====== INITIALIZATION ====== #

func _ready() -> void:
    super()
    # ---
    if not(is_instance_valid(sprite_anim)):
        sprite_anim = Utilities.find_first_child_of_type(parent_ctrl, AnimatedOverlay) as AnimatedOverlay
        if not(is_instance_valid(sprite_anim)):
            push_error("Error extra animation not found.")
    # ---
    sprite_anim.animated_sprite_2d.play("default_bloody")
    # ---
    splash_screen = Utilities.find_first_child_of_type(get_tree().root, SplashScreens) as SplashScreens
    if not(is_instance_valid(splash_screen)):
        push_error("not splash screen found")
    call_deferred("setup_animation")


# ====== MANAGEMENT ====== #

func setup_animation()->void:
    parent_ctrl.position += start_pos
    if is_instance_valid(splash_screen):
        await splash_screen.SplashScreensFinished
    #call_deferred("play_animation")
    play_animation()

func end_animation_func()->void:
    sprite_anim.play_animation()
    return
