class_name CleaningHand
extends Node2D


#@export var framing_tool         : TemperingTool
#@export var cleaning_tool        : TemperingTool
# ---
@export var cleaning_aspect      : Texture2D
@export var cleaning_done_aspect : Texture2D
@export var framing_zone         : ClickableZone # zone for framing forensics

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
