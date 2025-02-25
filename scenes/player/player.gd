class_name Player
extends BodyMotor


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
    EventBus.EnableCleaningZoneDisplay.connect(
        func():
            cleaning_zone.enable_zone_aspect(true)
            framing_zone .enable_zone_aspect(false)
    )
    EventBus.EnableFramingZoneDisplay .connect(
        func():
            cleaning_zone.enable_zone_aspect(false)
            framing_zone .enable_zone_aspect(true)
    )
    # ---
    PlayerStatistics.CurrentToolUpdated.connect(set_draw_zone_res)
    EventBus.EnableCleaningZoneDisplay.emit()

# ====== MANAGEMENT ====== #

func set_draw_zone_res()->void:
    if is_instance_valid(cleaning_zone):
        cleaning_zone.clickable_zone = PlayerStatistics.current_cleaning_tool.clickable_zone
    if is_instance_valid(framing_zone):
        framing_zone .clickable_zone = PlayerStatistics.current_framing_tool .clickable_zone
