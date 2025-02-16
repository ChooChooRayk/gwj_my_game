class_name InspectorIdleState
extends InspectorState


# ====== PROCESS ====== #


# ====== MANAGEMENT ====== #

func enter()->void:
    inspector_ai.go_to_target = false
    await get_tree().create_timer(2).timeout
    ChangeStateRequested.emit(self, STATES.Scouting)
    return
    
func exit()->void:
    return

func update_state()->void:
    return
