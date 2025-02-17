class_name HandStateMachine
extends Node


@export var init_state:HandState.STATES = HandState.STATES.OutZone

var state_lib     : Dictionary = {}
var current_state : HandState

# ====== INITIALIZATION ====== #

func _ready() -> void:
    init_state_machine()
    return
    
func init_state_machine()->void:
    state_lib.clear()
    for state:HandState in get_children():
        state.ChangeStateRequested.connect(on_change_state_requested)
        state_lib[state.state] = state
    # ---
    if state_lib.keys().has(init_state):
        current_state = state_lib[init_state] as HandState
        current_state.enter()
    return

# ====== PROCESS ====== #

func update_state()->void:
    current_state.update_state()
    return

func process_input(event:InputEvent)->void:
    current_state.process_input(event)

# ====== MANAGEMENT ====== #

func on_change_state_requested(from_state:HandState, next_state:HandState.STATES)->void:
    if (from_state!=current_state):
        return
    # ---
    var new_state = state_lib[next_state] as HandState
    current_state.exit()
    new_state    .enter()
    # ---
    current_state = new_state
    print("hand state : ", current_state.state)
    return
