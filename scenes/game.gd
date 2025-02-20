class_name Game
extends Node


@onready var scene_transition_overlay: SceneTransitionOverlay = %SceneTransitionOverlay


@export var gui_container        : CanvasLayer
@export var main_scene_container : Node2D
var current_gui   : Control
var current_scene : Node

var scene_still_loaded : Array  = []
var ui_node_dic : Dictionary    = {}

# ====== INITIALIZATION ====== #

func _ready() -> void:
    SceneManager.game_manager = self
    # ---
    current_gui   = gui_container.get_child(0)
    #current_scene = main_scene_container.get_child(0)
    # ---
    clean_remove_current_scene()
    # ---  --- #
    ui_node_dic[GlobalSettings.UI_KEYS.MAIN_MENU  ] = Utilities.find_first_child_of_type(gui_container, GameMenu) as GameMenu
    ui_node_dic[GlobalSettings.UI_KEYS.NEW_MISSION] = Utilities.find_first_child_of_type(gui_container, NewMissionMenu) as NewMissionMenu
    EventBus.ChangeMainUIRequested.connect(change_to_gui_scene)
    # ---
    EventBus.ChangeMainSceneRequested.connect(change_to_main_scene)
    EventBus.PauseMainSceneRequested .connect(pause_main_scene )
    EventBus.ResetMissionRequested   .connect(reset_missions   )
    EventBus.MissionValidated        .connect(func (): PlayerStatistics.set_next_level())
    #start_splash_screens("res://scenes/start_spalsh_screens/splash_screens.tscn")

# ====== MANAGEMENT ====== #

func change_to_main_scene(new_scene_key:GlobalSettings.SCENE_KEYS)->void:
    reset_game_default_settings()
    # ---
    var new_scene_path := GlobalSettings.scene_path_dic[new_scene_key] as String
    var new_scene      :PackedScene = load(new_scene_path) as PackedScene
    # ---
    scene_transition_overlay.transition(SceneTransitionOverlay.TRANS_TYPE.FADE_OUT)
    await scene_transition_overlay.animation_player.animation_finished
    # ---
    current_gui.visible = false
    # ---
    if is_instance_valid(new_scene):
        var new_main_scene = check_if_scene_already_loaded(new_scene)
        if not(is_instance_valid(new_main_scene)):
            new_main_scene = new_scene.instantiate()
        # ---
        clean_remove_current_scene()
        main_scene_container.add_child(new_main_scene)
        # ---
        current_scene      = new_main_scene
    # ---
    if current_scene is Level:
        current_scene.init_level()
    # ---
    pause_main_scene(false)
    scene_transition_overlay.transition(SceneTransitionOverlay.TRANS_TYPE.FADE_IN)
    await scene_transition_overlay.animation_player.animation_finished
    # ---
    EventBus.ChangeSceneFinished.emit()
    return

func change_to_gui_scene(new_ui_key:GlobalSettings.UI_KEYS)->void:
    reset_game_default_settings()
    pause_main_scene(true)
    # ---
    var new_ui = ui_node_dic[new_ui_key]
    if not(is_instance_valid(new_ui)):
        push_error("new ui invalid")
        return
    # ---
    scene_transition_overlay.transition(SceneTransitionOverlay.TRANS_TYPE.FADE_OUT)
    await scene_transition_overlay.animation_player.animation_finished
    # ---
    current_gui.visible = false
    new_ui.visible      = true
    current_gui = new_ui
    # ---
    scene_transition_overlay.transition(SceneTransitionOverlay.TRANS_TYPE.FADE_IN)
    await scene_transition_overlay.animation_player.animation_finished
    # ---
    EventBus.ChangeSceneFinished.emit()
    return

func check_if_scene_already_loaded(scene:PackedScene)->Node:
    for i in range(scene_still_loaded.size()):
        var item = scene_still_loaded[i] as Node
        if item.scene_file_path==scene.resource_path:
            return scene_still_loaded.pop_at(i)
    return null

func clean_remove_current_scene(delete_scene:bool=true)->void:
    if is_instance_valid(current_scene):
        if delete_scene:
            current_scene. free()#queue_free()
        else:
            scene_still_loaded.append(current_scene)
            main_scene_container.remove_child(current_scene)
    return

func pause_main_scene(to_pause:bool)->void:
    if not(is_instance_valid(current_scene)):
        return
    # ---
    if to_pause:
        current_scene.process_mode = Node.PROCESS_MODE_DISABLED
    else:
        current_scene.process_mode = Node.PROCESS_MODE_INHERIT

# ------------ #

func reset_game_default_settings()->void:
    Engine.time_scale = 1.0

func reset_missions()->void:
    PlayerStatistics.reset_stats()
    return
