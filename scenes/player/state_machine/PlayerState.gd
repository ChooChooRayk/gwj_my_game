class_name PlayerState
extends Node

signal ChangeStateRequested(from_state:HandState, to_state:STATES)

enum STATES {
    Normal,
    Hiding,
}
@export var state : STATES

var input_player : InputPlayer

# ====== INITIALIZATION ====== #

func _ready() -> void:
    input_player = Utilities.find_first_parent_of_type(self, InputPlayer) as InputPlayer
    if not(is_instance_valid(input_player)):
        push_error("No parent of type InputPlayer, not normal ...")
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
