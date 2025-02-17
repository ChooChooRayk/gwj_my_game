class_name Level
extends Node

@export var mission_res : MissionResource

var player_stat : PlayerStatistics

var mission_timer := Timer.new()
var hud_canvas    := CanvasLayer.new()
var hud           : HUD

var victory_panel_scene : PackedScene = load("res://scenes/menu_UI/victory_menu/victory_menu.tscn")
var defeat_panel_scene  : PackedScene = load("res://scenes/menu_UI/game_over_menu/game_over_menu.tscn")

# ====== INITIALIZATION ====== #

func _ready() -> void:
    hud = GlobalSettings.hud_scene.instantiate()
    hud_canvas.add_child(hud)
    add_child(hud_canvas)
    # ---
    mission_timer.autostart = true
    mission_timer.wait_time = mission_res.time_to_succeed
    mission_timer.one_shot  = true
    mission_timer.timeout.connect(mission_failed)
    add_child(mission_timer)

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
