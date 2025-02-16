class_name InspectorStateMachine
extends Node

@export var init_state:InspectorState.STATES = InspectorState.STATES.Idle

var state_lib     : Dictionary = {}
var current_state : InspectorState

# ====== INITIALIZATION ====== #

func _ready() -> void:
    init_state_machine()
    return
    
func init_state_machine()->void:
    state_lib.clear()
    for state:InspectorState in get_children():
        state.ChangeStateRequested.connect(on_change_state_requested)
        state_lib[state.state] = state
    # ---
    if state_lib.keys().has(init_state):
        current_state = state_lib[init_state] as InspectorState
        current_state.enter()
    return

# ====== PROCESS ====== #

func update_state()->void:
    current_state.update_state()
    return
    
func target_reached()->void:
    current_state.target_reached()

# ====== MANAGEMENT ====== #

func on_change_state_requested(from_state:InspectorState, next_state:InspectorState.STATES)->void:
    if (from_state!=current_state):
        return
    # ---
    var new_state = state_lib[next_state] as InspectorState
    current_state.exit()
    new_state    .enter()
    # ---
    current_state = new_state
    #print("inspector state : ", current_state.state)
    return
