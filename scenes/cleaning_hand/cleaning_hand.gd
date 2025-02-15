@tool
class_name CleaningHand
extends Node2D

@export var cleaning_aspect : Texture2D
@export var cleaning_tool   : CleaningTool

var item_to_clean  : CrimeEvidenceItem
var cleaning_timer :Timer = Timer.new()


@onready var aspect_nd : Sprite2D = $Sprite2D
@onready var cleaning_progress: TextureProgressBar = $CleaningProgress

# ====== INITIALIZATION ====== #

func _ready() -> void:
    #visible = false
    aspect_nd.texture = cleaning_aspect
    # ---
    cleaning_progress.visible = false
    # ---
    cleaning_timer.autostart = false
    cleaning_timer.one_shot  = true
    cleaning_timer.timeout.connect(crime_evidence_cleaned)
    add_child(cleaning_timer)
    # ---
    set_process(false)
    # ---  --- #
    EventBus.EvidenceCleaningStarted.connect(start_cleaning)
    EventBus.EvidenceCleaningStopped.connect(stop_cleaning)

# ====== PROCESS ====== #

func _process(delta: float) -> void:
    cleaning_progress.value = 100. * (1 - cleaning_timer.time_left / cleaning_timer.wait_time)
    return

# ====== MANAGEMENT ====== #

func set_new_cleaning_tool(tool:CleaningTool)->void:
    cleaning_tool = tool

func start_cleaning(crime_item:CrimeEvidenceItem)->void:
    if not(is_instance_valid(cleaning_tool)) or not(cleaning_timer.is_stopped()):
        return
    # ---
    item_to_clean = crime_item
    # ---
    cleaning_progress.value   = 0
    cleaning_progress.visible = true
    # ---
    cleaning_timer.wait_time = cleaning_tool.cleaning_duration
    cleaning_timer.start()
    set_process(true)
    return
    
func stop_cleaning()->void:
    cleaning_timer.stop()
    # ---
    cleaning_progress.visible = false
    set_process(false)
    
func crime_evidence_cleaned()->void:
    EventBus.EvidenceCleaned.emit(item_to_clean)
