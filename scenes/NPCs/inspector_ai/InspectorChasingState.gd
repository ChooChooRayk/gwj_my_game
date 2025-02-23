class_name InspectorChasingState
extends InspectorState

@export var stop_alert_time : float = 10. # [s]
var stop_alert_timer : Timer

# ====== INITIALIZATION ====== #

func _ready() -> void:
    super()
    set_process(false)
    EventBus.SuspectCaught.connect(on_suspect_caught)
    # ---
    stop_alert_timer = Timer.new()
    stop_alert_timer.wait_time = stop_alert_time
    stop_alert_timer.one_shot  = true
    stop_alert_timer.autostart = false
    stop_alert_timer.timeout.connect(set_to_not_alerted)
    add_child(stop_alert_timer)

# ====== PROCESS ====== #

func _process(_delta: float) -> void:
    inspector_ai.move_to(inspector_ai.target_to_chase.global_position)

# ====== MANAGEMENT ====== #

func enter()->void:
    super()
    # ---
    stop_alert_timer.stop()
    inspector_ai.is_alerted     = true
    inspector_ai.npc_body.SPEED = (inspector_ai.npc_body as Inspector).running_speed
    # ---
    inspector_ai.go_to_target = true
    (inspector_ai.npc_body as Inspector).catching_zone.set_deferred("monitoring", true)
    # ---
    set_process(true)
    return
    
func exit()->void:
    super()
    # ---
    set_process(false)
    # ---
    inspector_ai.npc_body.SPEED = (inspector_ai.npc_body as Inspector).walking_speed
    # ---
    (inspector_ai.npc_body as Inspector).catching_zone.set_deferred("monitoring", false)
    return

func on_suspect_caught(_body:BodyMotor)->void:
    ChangeStateRequested.emit(self, STATES.Idle)
    return

func check_hiding_valid()->void:
    super()
    ChangeStateRequested.emit(self,STATES.LookingAround)

    print("start alert countdown")
    stop_alert_timer.start()
    return

func set_to_not_alerted()->void:
    print("stop being alert")
    inspector_ai.is_alerted = false
    return
