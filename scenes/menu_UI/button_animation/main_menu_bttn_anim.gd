class_name MainMenuAnimButton
extends ControlAnimation

@export var sprite_anim : AnimatedOverlay
@export var splash_screen : SplashScreens

var init_enable : bool

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
    init_enable = sprite_anim.enable_animation
    sprite_anim.enable_animation = false
    parent_ctrl.modulate = Color(Color.WHITE,0.0)
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
    parent_ctrl.modulate = Color(Color.WHITE,1.0)
    play_animation()

func end_animation_func()->void:
    sprite_anim.play_animation()
    await sprite_anim.animated_sprite_2d.animation_finished
    sprite_anim.enable_animation = init_enable
    return
