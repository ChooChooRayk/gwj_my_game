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
    EventBus.PlayerHidingRequested.connect(check_hiding_valid)
    return
    
func exit()->void:
    EventBus.PlayerHidingRequested.disconnect(check_hiding_valid)
    return

func update_state()->void:
    return

func process_input(_event:InputEvent)->void:
    return
    
func target_reached()->void:
    return

# ------------ #

func check_hiding_valid()->void:
    var detection_zone := inspector_ai.detection_zone
    if !detection_zone.monitoring:
        return
    # ---
    var body_list : Array[Node2D] = detection_zone.get_overlapping_bodies()
    for body in body_list:
        if body.is_in_group("player"):
            print("hiding not valid !")
            EventBus.PlayerHidingFailed.emit()
            # ---
            #inspector_ai.target_to_chase = body
            #ChangeStateRequested.emit(self,STATES.Chasing)
            return
    # ---
    print("hiding valid :) ")
    #ChangeStateRequested.emit(self,STATES.Scouting)
    return
