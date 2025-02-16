class_name InspectorScoutingState
extends InspectorState

# ====== INITIALIZATION ====== #

func _ready() -> void:
    super()
    

# ====== PROCESS ====== #

# ====== MANAGEMENT ====== #

func enter()->void:
    inspector_ai.go_to_target = false
    inspector_ai.move_to_next_path_position()
    return
    
func exit()->void:
    return

func target_reached()->void:
    if inspector_ai.follow_path:
        inspector_ai.move_to_next_path_position()
    return
    
