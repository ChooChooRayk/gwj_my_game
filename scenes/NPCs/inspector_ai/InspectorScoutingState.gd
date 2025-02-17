class_name InspectorScoutingState
extends InspectorState


var rng := RandomNumberGenerator.new()

# ====== INITIALIZATION ====== #

func _ready() -> void:
    super()
    EventBus.SuspectDetected.connect(suspect_detected)
    

# ====== PROCESS ====== #

# ====== MANAGEMENT ====== #

func enter()->void:
    inspector_ai.go_to_target = false
    inspector_ai.move_to_next_path_position()
    return
    
func exit()->void:
    return

func target_reached()->void:
    var is_looking_around = rng.randf()>0.75
    print("Is going to look around : ", is_looking_around)
    if is_looking_around:
        ChangeStateRequested.emit(self, STATES.LookingAround)
        return
    # ---
    inspector_ai.move_to_next_path_position()
    return
    
func suspect_detected(player:BodyMotor)->void:
    ChangeStateRequested.emit(self, STATES.Chasing)
    return
