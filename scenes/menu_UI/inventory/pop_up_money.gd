class_name PopUpMoney
extends Label

@export var anim_duration := 1.0 # [s]
@export var delta_money   : float = 0.
@export var trans_type    : Tween.TransitionType
@export var ease_type     : Tween.EaseType

var tween : Tween
var text_color : Color
var delta_pos  := Vector2(0.,-32)

func _ready() -> void:
    visible = false
    # ---
    if delta_money==0:
        queue_free()
        return
    # ---
    if sign(delta_money)>0:
        text_color = Color.GREEN
    else:
        text_color = Color.RED
    # ---
    text = "{money}".format({"money":delta_money})
    return

func play_animation()->void:
    visible = true
    # ---
    tween = get_tree().create_tween()
    tween.set_trans(trans_type).set_ease(ease_type)
    # ---
    tween.parallel().tween_property(self, "position", position +delta_pos, anim_duration)
    tween.parallel().tween_property(self, "modulate", Color(text_color,0), anim_duration).from(text_color)
    tween.finished.connect(func ():queue_free())
    tween.play()
