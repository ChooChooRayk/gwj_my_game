class_name InspectorLookAroundState
extends InspectorState

@export var time_to_next_look := 1. # [s]
@export var nbr_of_looking    := 3
var looking_count := 0

var next_head_look_timer : Timer
var rng := RandomNumberGenerator.new()

var tween : Tween
var twen_duration := 0.5 # [s]
func _ready() -> void:
    super()
    next_head_look_timer           = Timer.new()
    next_head_look_timer.wait_time = time_to_next_look
    next_head_look_timer.one_shot  = true
    next_head_look_timer.timeout.connect(look_around)
    add_child(next_head_look_timer)
    # ---
    EventBus.SuspectDetected.connect(suspect_detected)

# ====== PROCESS ====== #

# ====== MANAGEMENT ====== #

func enter()->void:
    inspector_ai.go_to_target = false
    looking_count = 0
    next_head_look_timer.start()
    return
    
func exit()->void:
    next_head_look_timer.stop()
    return

func look_around()->void:
    if looking_count>=nbr_of_looking:
        ChangeStateRequested.emit(self, STATES.Scouting)
        return
    # ---
    rotate_detection_zone_random()
    looking_count += 1
    return

func rotate_detection_zone_random()->void:
    var rot_agl := inspector_ai.detection_zone.rotation + rng.randf_range(-PI/2., PI/2.)
    # ---
    tween = get_tree().create_tween()
    tween.set_trans(Tween.TransitionType.TRANS_CUBIC)
    tween.set_ease (Tween.EASE_IN)
    tween.tween_property(inspector_ai.detection_zone, "rotation", rot_agl, twen_duration)
    tween.play()
    tween.finished.connect(func (): next_head_look_timer.start())
    return

func suspect_detected(_player:BodyMotor)->void:
    ChangeStateRequested.emit(self, STATES.Chasing)
    return
