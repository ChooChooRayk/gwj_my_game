class_name InspectorChasingState
extends InspectorState


# ====== INITIALIZATION ====== #

func _ready() -> void:
    super()
    set_process(false)
    if is_instance_valid((inspector_ai.npc_body as Inspector).catching_zone):
        (inspector_ai.npc_body as Inspector).catching_zone.body_entered.connect(on_catching_body)

# ====== PROCESS ====== #

func _process(_delta: float) -> void:
    inspector_ai.move_to(inspector_ai.target_to_chase.global_position)

# ====== MANAGEMENT ====== #

func enter()->void:
    set_process(true)
    inspector_ai.go_to_target = true
    (inspector_ai.npc_body as Inspector).catching_zone.monitoring = true
    return
    
func exit()->void:
    set_process(false)
    (inspector_ai.npc_body as Inspector).catching_zone.monitoring = false
    return

#func target_reached()->void:
    #EventBus.SuspectCaught.emit(inspector_ai.target_to_chase)
    #ChangeStateRequested.emit(self, STATES.Idle)
    #return
    
func on_catching_body(body:Node2D)->void:
    if body.is_in_group("player"):
        EventBus.SuspectCaught.emit(inspector_ai.target_to_chase)
        ChangeStateRequested.emit(self, STATES.Idle)        
    return
