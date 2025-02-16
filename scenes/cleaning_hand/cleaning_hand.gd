class_name CleaningHand
extends Node2D

@export var cleaning_tool        : CleaningTool
@export var cleaning_aspect      : Texture2D
@export var cleaning_done_aspect : Texture2D

var item_to_clean  : CrimeEvidenceItem
var cleaning_timer :Timer = Timer.new()

@onready var aspect_nd : Sprite2D = $Sprite2D
@onready var hand_state_machine: HandStateMachine = %HandStateMachine


# ====== INITIALIZATION ====== #

# ====== PROCESS ====== #

func _process(_delta: float) -> void:
    #print(cleaning_tool.cleanable_zone.is_point_in_zone(get_global_mouse_position()))
    hand_state_machine.update_state()
    return

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT:
        hand_state_machine.process_input(event)
        get_tree().root.set_input_as_handled()

# ====== MANAGEMENT ====== #

func set_new_cleaning_tool(tool:CleaningTool)->void:
    cleaning_tool = tool

func crime_evidence_cleaned()->void:
    EventBus.EvidenceCleaned.emit(item_to_clean)
