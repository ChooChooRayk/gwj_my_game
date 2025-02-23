class_name PlayerNPC
extends BodyMotor


@export var enable_cleaning_zone := false
@export var enable_framing_zone  := false
@export_category("Movement")
@export var walking_speed : float = 100.
@export var running_speed : float = 100.

@onready var cleaning_zone: ClickableZoneDisplayer = %DrawCleaningZone
@onready var framing_zone : ClickableZoneDisplayer = %DrawFramingZone

# ====== INITIALIZATION ====== #

func _ready() -> void:
    super()
    # ---
    SPEED = walking_speed
    # ---
    if is_instance_valid(cleaning_zone):
        cleaning_zone.clickable_zone = PlayerStatistics.current_cleaning_tool.clickable_zone
    if is_instance_valid(framing_zone):
        framing_zone .clickable_zone = PlayerStatistics.current_framing_tool .clickable_zone
    # ---
    enable_cleaning_zone_func(enable_cleaning_zone)
    enable_framing_zone_func (enable_framing_zone )
    # ---
    #PlayerStatistics.CurrentToolUpdated.connect(set_draw_zone_res)
    #EventBus.EnableCleaningZoneDisplay.emit()
    # ---
    set_physics_process(false)

# ====== PROCESS ====== #

#func _physics_process(_delta: float) -> void:
    #return

# ====== MANAGEMENT ====== #

func set_draw_zone_res()->void:
    if is_instance_valid(cleaning_zone):
        cleaning_zone.clickable_zone = PlayerStatistics.current_cleaning_tool.clickable_zone
    if is_instance_valid(framing_zone):
        framing_zone .clickable_zone = PlayerStatistics.current_framing_tool .clickable_zone

func enable_cleaning_zone_func(val:bool)->void:
    cleaning_zone.enable_zone_aspect(val)

func enable_framing_zone_func(val:bool)->void:
    framing_zone .enable_zone_aspect(val)
