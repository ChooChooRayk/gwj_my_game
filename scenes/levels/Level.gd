class_name Level
extends Node

signal LevelUpdated()

var mission_res : MissionResource

#var player_stat : PlayerStatistics
var cleaning_hand : CleaningHand
var player        : Player

var mission_timer := Timer.new()
var hud_canvas    := CanvasLayer.new()
var hud           : HUD
var start_pos     : StartLevelPosition
var pause_menu    : PauseMenu

var pause_menu_scene    : PackedScene = load("res://scenes/menu_UI/pause_menu/pause_menu.tscn")
var victory_panel_scene : PackedScene = load("res://scenes/menu_UI/victory_menu/victory_menu.tscn")
var defeat_panel_scene  : PackedScene = load("res://scenes/menu_UI/game_over_menu/game_over_menu.tscn")

var item_left_to_hide : int

# ====== INITIALIZATION ====== #

func _ready() -> void:
    var mission_key :GlobalSettings.MISSION_KEYS = PlayerStatistics.mission_manager.get_current_mission()
    if mission_key==-1:
        push_error("error in current mission in MissionManager")
    mission_res = GlobalSettings.missions_dic[mission_key] as MissionResource
    # ---
    cleaning_hand     = Utilities.find_first_child_of_type(self, CleaningHand) as CleaningHand
    # if is_instance_valid(cleaning_hand):
        # cleaning_hand.set_new_tool(PlayerStatistics.current_cleaning_tool)
        # cleaning_hand.set_new_tool(PlayerStatistics.current_framing_tool )
    # ---
    player    = Utilities.find_first_child_of_type(self, Player) as Player
    start_pos = Utilities.find_first_child_of_type(self, StartLevelPosition) as StartLevelPosition
    # ---
    hud = GlobalSettings.hud_scene.instantiate()# as HUD
    hud_canvas.add_child(hud)
    add_child(hud_canvas)
    # ---
    pause_menu = pause_menu_scene.instantiate() as PauseMenu
    hud_canvas.add_child(pause_menu)
    # ---
    mission_timer.autostart = false
    mission_timer.wait_time = mission_res.time_to_succeed
    mission_timer.one_shot  = true
    mission_timer.timeout.connect(mission_failed)
    add_child(mission_timer)
    # ---
    EventBus.SuspectCaught  .connect(func (_body): mission_failed())
    EventBus.EvidenceCleaned.connect(on_evidence_cleaned)
    EventBus.EvidenceHidden .connect(on_evidence_hidden )

func init_level()->void:
    item_left_to_hide = mission_res.crime_evidence_number
    # ---
    if is_instance_valid(start_pos) and is_instance_valid(player):
        player.global_position = start_pos.global_position
    # ---
    hud.init_hud()
    mission_timer.start()
    # ---
    LevelUpdated.emit()
    return

# ====== PROCESS ====== #

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("pause_game"):
        toggle_pause_game()
        get_viewport().set_input_as_handled()


# ====== MANAGEMENT ====== #

func toggle_pause_game()->void:
    print("toggle pausing")
    var is_game_paused = get_tree().paused
    pause_menu.visible = !is_game_paused
    get_tree().paused  = !is_game_paused

func mission_failed()->void:
    Engine.time_scale = 0.1
    # ---
    var gameover_menu = defeat_panel_scene.instantiate()
    hud_canvas.add_child(gameover_menu)
    # ---
    EventBus.MissionFailled.emit()
    end_level()
    return

func mission_succeeded()->void:
    Engine.time_scale = 0.1
    # ---
    var victory_menu := victory_panel_scene.instantiate() as VictoryMenu
    hud_canvas.add_child(victory_menu)
    # ---
    EventBus.MissionValidated.emit()
    end_level()
    return

func end_level()->void:
    mission_timer.stop()
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
