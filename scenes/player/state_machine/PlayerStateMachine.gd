class_name PlayerStateMachine
extends Node


@export var init_state:PlayerState.STATES = PlayerState.STATES.Normal

var state_lib     : Dictionary = {}
var current_state : PlayerState

# ====== INITIALIZATION ====== #

func _ready() -> void:
    await get_parent().ready
    init_state_machine()
    # ---
    EventBus.PlayerHidingFailed.connect(func ():current_state.is_discovered=true)
    return
    
func init_state_machine()->void:
    state_lib.clear()
    for state:PlayerState in get_children():
        state.ChangeStateRequested.connect(on_change_state_requested)
        state_lib[state.state] = state
    # ---
    if state_lib.keys().has(init_state):
        current_state = state_lib[init_state] as PlayerState
        current_state.enter()
    return

# ====== PROCESS ====== #

func update_state()->void:
    current_state.update_state()
    return

func process_input(event:InputEvent)->void:
    current_state.process_input(event)

# ====== MANAGEMENT ====== #

func on_change_state_requested(from_state:PlayerState, next_state:PlayerState.STATES)->void:
    if (from_state!=current_state):
        return
    # ---
    var new_state = state_lib[next_state] as PlayerState
    current_state.exit()
    new_state    .enter()
    # ---
    current_state = new_state
    #print("player state : ", current_state.state)
    return
