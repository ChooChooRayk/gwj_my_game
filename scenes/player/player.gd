class_name Player
extends BodyMotor

var cleaning_zone : AllowedCleaningZone

# ====== INITIALIZATION ====== #

func _ready() -> void:
    cleaning_zone = Utilities.find_first_child_of_type(self, AllowedCleaningZone) as AllowedCleaningZone
    if is_instance_valid(cleaning_zone):
        cleaning_zone.cleanable_zone = PlayerStatistics.current_cleaning_tool.cleanable_zone
