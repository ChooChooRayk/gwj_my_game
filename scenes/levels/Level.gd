class_name Level
extends Node

signal LevelUpdated()

@export var mission_res : MissionResource

#var player_stat : PlayerStatistics
var cleaning_hand : CleaningHand

var mission_timer := Timer.new()
var hud_canvas    := CanvasLayer.new()
var hud           : HUD

var victory_panel_scene : PackedScene = load("res://scenes/menu_UI/victory_menu/victory_menu.tscn")
var defeat_panel_scene  : PackedScene = load("res://scenes/menu_UI/game_over_menu/game_over_menu.tscn")

var item_left_to_hide : int

# ====== INITIALIZATION ====== #

func _ready() -> void:
    cleaning_hand     = Utilities.find_first_child_of_type(self, CleaningHand) as CleaningHand
    if is_instance_valid(cleaning_hand):
        cleaning_hand.cleaning_tool = PlayerStatistics.current_cleaning_tool
    # ---
    item_left_to_hide = mission_res.crime_evidence_number
    # ---
    hud = GlobalSettings.hud_scene.instantiate()
    hud_canvas.add_child(hud)
    add_child(hud_canvas)
    # ---
    mission_timer.autostart = true
    mission_timer.wait_time = mission_res.time_to_succeed
    mission_timer.one_shot  = true
    mission_timer.timeout.connect(mission_failed)
    add_child(mission_timer)
    # ---
    EventBus.EvidenceCleaned.connect(on_evidence_cleaned)
    EventBus.EvidenceHidden .connect(on_evidence_hidden )
    # ---
    LevelUpdated.emit()

# ====== PROCESS ====== #

# ====== MANAGEMENT ====== #

func mission_failed()->void:
    Engine.time_scale = 0.1
    # ---
    var gameover_menu = defeat_panel_scene.instantiate()
    hud_canvas.add_child(gameover_menu)
    return

func mission_succeeded()->void:
    var victory_menu = victory_panel_scene.instantiate()
    hud_canvas.add_child(victory_menu)
    return

func on_evidence_cleaned(item:CrimeEvidenceItem)->void:
    item.set_cleaned()
    check_for_mission_success()

func on_evidence_hidden(_item:CrimeEvidenceItem)->void:
    item_left_to_hide -= 1
    check_for_mission_success()
    LevelUpdated.emit()

func check_for_mission_success()->void:
    if item_left_to_hide==0:
        mission_succeeded()
