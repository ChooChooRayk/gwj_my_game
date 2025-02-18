extends Node

var inventory
var current_cleaning_tool : CleaningTool

var current_level_idx : int
var level_list : Array[GlobalSettings.SCENE_KEYS] = [
    GlobalSettings.SCENE_KEYS.TEST,
]

# ====== MANAGEMENT ====== #

func get_next_level()->GlobalSettings.SCENE_KEYS:
    current_level_idx += 1
    if current_level_idx>=level_list.size():
        return GlobalSettings.SCENE_KEYS.LEVEL_FINAL
    return level_list[current_level_idx]
