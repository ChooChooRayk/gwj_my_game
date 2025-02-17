class_name InspectorState
extends Node

signal ChangeStateRequested(from_state:HandState, to_state:STATES)

enum STATES {
    Idle,
    Scouting,
    Chasing,
    LookingAround,
}
@export var state : STATES

var inspector_ai : InspectorAI

# ====== INITIALIZATION ====== #

func _ready() -> void:
    inspector_ai = Utilities.find_first_parent_of_type(self, InspectorAI)
    if not(is_instance_valid(inspector_ai)):
        push_error("No parent of type InspectorAI, not normal ...")
    return

# ====== MANAGEMENT ====== #

func enter()->void:
    return
    
func exit()->void:
    return

func update_state()->void:
    return

func process_input(_event:InputEvent)->void:
    return
    
func target_reached()->void:
    return
