class_name InspectorLookAroundState
extends InspectorState

@export var time_to_next_look := 1. # [s]
@export var nbr_of_looking    := 3
var looking_count := 0

var next_head_look_timer : Timer
var rng := RandomNumberGenerator.new()

var tween : Tween
var twen_duration := 0.5 # [s]
var looking_dir : Vector2 = Vector2.ZERO

# ====== INITIALIZATION ====== #

func _ready() -> void:
    super()
    next_head_look_timer           = Timer.new()
    next_head_look_timer.wait_time = time_to_next_look
    next_head_look_timer.one_shot  = true
    next_head_look_timer.timeout.connect(look_around)
    add_child(next_head_look_timer)
    # ---
    set_physics_process(false)
    # ---
    EventBus.SuspectDetected.connect(suspect_detected)

# ====== PROCESS ====== #

func _physics_process(_delta: float) -> void:
    inspector_ai.npc_body.last_direction = looking_dir
    inspector_ai.npc_body.manage_animation()

# ====== MANAGEMENT ====== #

func enter()->void:
    super()
    # ---
    looking_dir = inspector_ai.npc_body.last_direction
    # ---
    inspector_ai.go_to_target = false
    inspector_ai.npc_body.set_physics_process(false)
    set_physics_process(true)
    # ---
    looking_count = 0
    next_head_look_timer.start()
    return
    
func exit()->void:
    super()
    # ---
    set_physics_process(false)
    inspector_ai.npc_body.set_physics_process(true)
    # ---
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
    #inspector_ai.
    # ---
    tween = get_tree().create_tween()
    tween.set_trans(Tween.TransitionType.TRANS_CUBIC)
    tween.set_ease (Tween.EASE_IN)
    tween.parallel().tween_property(self, "looking_dir", Vector2(cos(rot_agl),sin(rot_agl)), twen_duration)
    tween.parallel().tween_property(inspector_ai.detection_zone, "rotation", rot_agl, twen_duration)
    tween.parallel().tween_property(inspector_ai.detection_zone, "scale", Vector2(0.5+abs(cos(rot_agl))/2., 1.), twen_duration)
    tween.play()
    tween.finished.connect(func (): next_head_look_timer.start())
    return


func suspect_detected(player:BodyMotor)->void:
    inspector_ai.target_to_chase = player
    ChangeStateRequested.emit(self, STATES.Chasing)
    return
