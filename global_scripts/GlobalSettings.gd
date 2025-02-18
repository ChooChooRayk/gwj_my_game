#class_name GlobalSettings
extends Node

enum LAYER_NAMES {
    MAP = 1<<0,
    BODIES = 1<<1,
    EVIDENCE_ITEM = 1<<2,
}

enum UI_KEYS {
    MAIN_MENU,
    NEW_MISSION,
}

enum SCENE_KEYS {
    TEST,
    LEVEL_1,
    LEVEL_FINAL,
}
static var scene_path_dic : Dictionary = {
    SCENE_KEYS.TEST       : "res://scenes/levels/level_test/lvl_test.tscn",
    SCENE_KEYS.LEVEL_1    : "res://scenes/levels/level_1/level_1.tscn",
    SCENE_KEYS.LEVEL_FINAL: "res://scenes/levels/level_final/level_final.tscn",    
}

var current_game_settings := {
    "master_vol" : 0.,
    "sfx_vol"    : 0.,
    "windowing"  : 0,
    "tutorial"   : true,
}
var default_game_settings := {
    "master_vol" : 0.,
    "sfx_vol"    : 0.,
    "windowing"  : 0,
    "tutorial"   : true,
}





static var hud_scene :PackedScene = load("res://scenes/menu_UI/hud/hud.tscn")
