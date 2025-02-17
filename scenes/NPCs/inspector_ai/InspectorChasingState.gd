class_name InspectorChasingState
extends InspectorState


# ====== INITIALIZATION ====== #

func _ready() -> void:
    super()
    set_process(false)

# ====== PROCESS ====== #

func _process(delta: float) -> void:
    inspector_ai.move_to(inspector_ai.target_to_chase.global_position)

# ====== MANAGEMENT ====== #

func enter()->void:
    set_process(true)
    inspector_ai.go_to_target = true
    return
    
func exit()->void:
    set_process(false)
    return

func target_reached()->void:
    EventBus.SuspectCaught.emit(inspector_ai.target_to_chase)
    ChangeStateRequested.emit(self, STATES.Idle)
    return
