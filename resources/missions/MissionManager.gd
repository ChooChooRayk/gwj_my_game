class_name MissionManager
extends Resource

@export var mission_list : Array[GlobalSettings.MISSION_KEYS]
@export var current_mission_idx : int

func get_current_mission()->GlobalSettings.MISSION_KEYS:
    if current_mission_idx==-1:
        return GlobalSettings.MISSION_KEYS.LEVEL_FINAL
    if mission_list.size()!=0:
        return mission_list[current_mission_idx]
    # ---
    return GlobalSettings.MISSION_KEYS.LEVEL_FINAL

func set_next_mission()->void:
    current_mission_idx += 1
    if current_mission_idx>=mission_list.size():
        current_mission_idx = -1

func reset_missions()->void:
    current_mission_idx = 0
