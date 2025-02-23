#class_name GlobalSettings
extends Node

enum LAYER_NAMES {
    MAP = 1<<0,
    BODIES = 1<<1,
    EVIDENCE_ITEM = 1<<2,
    DETECTION = 1<<3,
}

enum Z_ORDER {
    FLOOR      = 0,
    WALL       = 1,
    CONTENT    = 2,
    OVERLAY    = 3,
    NAVIGATION = 4,
}

enum UI_KEYS {
    MAIN_MENU,
    NEW_MISSION,
}

enum MISSION_KEYS {LEVEL_0, LEVEL_1, LEVEL_FINAL}
static var missions_dic : Dictionary = {
    MISSION_KEYS.LEVEL_0    : load("res://resources/missions/mission_level_0.tres") as MissionResource,
    MISSION_KEYS.LEVEL_1    : load("res://resources/missions/mission_level_1.tres") as MissionResource,
    MISSION_KEYS.LEVEL_FINAL: load("res://resources/missions/mission_level_final.tres") as MissionResource,    
}

var current_game_settings := {
    "master_vol" : 0.,
    "music_vol"  : 0.,
    "sfx_vol"    : 0.,
    "windowing"  : 0,
    "tutorial"   : true,
}
var default_game_settings := {
    "master_vol" : 0.,
    "music_vol"  : 0.,
    "sfx_vol"    : 0.,
    "windowing"  : 0,
    "tutorial"   : true,
}


static var hud_scene :PackedScene = load("res://scenes/menu_UI/hud/hud.tscn")
