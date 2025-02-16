class_name HandState
extends Node


signal ChangeStateRequested(from_state:HandState, to_state:STATES)

enum STATES {
    OutZone,
    InZone,
    InCleaning,
    CleaningDone,
}
@export var state : STATES

var cleaning_hand : CleaningHand

# ====== INITIALIZATION ====== #

func _ready() -> void:
    cleaning_hand = Utilities.find_first_parent_of_type(self, CleaningHand)
    if not(is_instance_valid(cleaning_hand)):
        push_error("No parent of type CleaningHand, not normal ...")
    return

# ====== MANAGEMENT ====== #

func enter()->void:
    return
    
func exit()->void:
    return

func update_state()->void:
    return

func process_input(event:InputEvent)->void:
    return
