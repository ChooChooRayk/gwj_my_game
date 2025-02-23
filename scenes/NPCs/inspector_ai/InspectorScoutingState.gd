class_name InspectorScoutingState
extends InspectorState


var rng := RandomNumberGenerator.new()


# ====== INITIALIZATION ====== #

func _ready() -> void:
    super()
    EventBus.SuspectDetected    .connect(suspect_detected)
    

# ====== PROCESS ====== #

# ====== MANAGEMENT ====== #

func enter()->void:
    super()
    # ---
    if not(is_instance_valid((inspector_ai.npc_body as Inspector).scouting_targets)):
        ChangeStateRequested.emit(self, STATES.LookingAround)
    # ---
    inspector_ai.npc_body.SPEED = (inspector_ai.npc_body as Inspector).scouting_speed
    # ---
    inspector_ai.go_to_target = false
    inspector_ai.move_to_next_path_position()
    # ---
    EventBus.PlayerHidingStopped.connect(do_continue_pursuit)
    return

func exit()->void:
    super()
    # ---
    EventBus.PlayerHidingStopped.disconnect(do_continue_pursuit)

func target_reached()->void:
    var is_looking_around = rng.randf()>0.75
    if is_looking_around:
        ChangeStateRequested.emit(self, STATES.LookingAround)
        return
    # ---
    inspector_ai.move_to_next_path_position()
    return
    
func suspect_detected(player:BodyMotor)->void:
    inspector_ai.target_to_chase = player
    ChangeStateRequested.emit(self, STATES.Chasing)
    return
