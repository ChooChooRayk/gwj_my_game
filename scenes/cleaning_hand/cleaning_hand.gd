class_name CleaningHand
extends Node2D


@export var framing_zone         : ClickableZone # zone for framing forensics
@export_category("Cursor aspects")
@export var default_cursor_outzone_aspect : Texture2D# = load("res://assets/hand_cursor/cursor_hand_01.png") as Texture2D
@export var default_cursor_inzone_aspect  : Texture2D# = load("res://assets/hand_cursor/cursor_hand_inzone_01.png") as Texture2D
@export var hand_cursor_outzone_list      : Array[Texture2D]
@export var hand_cursor_inzone_list       : Array[Texture2D]
var cursor_outzone_aspect : Texture2D
var cursor_inzone_aspect  : Texture2D

var item_to_clean  : CrimeEvidenceItem
var cleaning_timer :Timer = Timer.new()

@onready var aspect_nd : Sprite2D = $Sprite2D
@onready var hand_state_machine: HandStateMachine = %HandStateMachine

var player : Player

# ====== INITIALIZATION ====== #

func _ready() -> void:
    var level : Level = Utilities.find_first_parent_of_type(self, Level) as Level
    if is_instance_valid(level):
        player = Utilities.find_first_child_of_type(self, Player) as Player
    else:
        print("level not found !!!")
    # ---
    if hand_cursor_outzone_list.size()!=0 and PlayerStatistics.mission_manager.current_mission_idx<=hand_cursor_outzone_list.size():
        cursor_outzone_aspect = hand_cursor_outzone_list[PlayerStatistics.mission_manager.current_mission_idx]
    else:
        cursor_outzone_aspect = default_cursor_outzone_aspect
    # ---
    if hand_cursor_inzone_list.size()!=0 and PlayerStatistics.mission_manager.current_mission_idx<=hand_cursor_inzone_list.size():
        cursor_inzone_aspect = hand_cursor_inzone_list[PlayerStatistics.mission_manager.current_mission_idx]
    else:
        cursor_inzone_aspect = default_cursor_inzone_aspect
    # ---
    Input.set_custom_mouse_cursor(default_cursor_outzone_aspect, Input.CURSOR_ARROW, Vector2(1,1))

        
# ====== PROCESS ====== #

func _process(_delta: float) -> void:
    hand_state_machine.update_state()
    return

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT:
        hand_state_machine.process_input(event)

# ====== MANAGEMENT ====== #

func crime_evidence_cleaned()->void:
    EventBus.EvidenceCleaned.emit(item_to_clean)
    EventBus.RemoveItemFromInventory.emit(PlayerStatistics.current_cleaning_tool) # maybe replace by PlayerStatistics.current_cleaning_tool

func crime_evidence_hidden()->void:
    EventBus.EvidenceHidden.emit(item_to_clean)
    EventBus.RemoveItemFromInventory.emit(PlayerStatistics.current_framing_tool) # maybe replace by PlayerStatistics.current_cleaning_tool
    return
