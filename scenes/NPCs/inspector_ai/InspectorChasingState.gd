class_name InspectorChasingState
extends InspectorState


# ====== INITIALIZATION ====== #

func _ready() -> void:
    super()
    set_process(false)
    EventBus.SuspectCaught.connect(on_suspect_caught)

# ====== PROCESS ====== #

func _process(_delta: float) -> void:
    print("target to chase : ", inspector_ai.target_to_chase)
    if not(is_instance_valid(inspector_ai.target_to_chase)):
        push_error("target to chase not valid ???")
    inspector_ai.move_to(inspector_ai.target_to_chase.global_position)

# ====== MANAGEMENT ====== #

func enter()->void:
    inspector_ai.npc_body.SPEED = (inspector_ai.npc_body as Inspector).running_speed
    # ---
    inspector_ai.go_to_target = true
    (inspector_ai.npc_body as Inspector).catching_zone.set_deferred("monitoring", true)
    # ---
    set_process(true)
    return
    
func exit()->void:
    set_process(false)
    # ---
    inspector_ai.npc_body.SPEED = (inspector_ai.npc_body as Inspector).walking_speed
    # ---
    (inspector_ai.npc_body as Inspector).catching_zone.set_deferred("monitoring", false)
    return

func on_suspect_caught(_body:BodyMotor)->void:
    ChangeStateRequested.emit(self, STATES.Idle)
    return
