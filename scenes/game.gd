class_name Game
extends Node


@onready var scene_transition_overlay: SceneTransitionOverlay = %SceneTransitionOverlay


@export var gui_container        : CanvasLayer
@export var main_scene_container : Node2D
var current_gui   : Control
var current_scene : Node

var scene_still_loaded : Array = []
var ui_node_dic : Dictionary   = {}
# ====== INITIALIZATION ====== #

func _ready() -> void:
    SceneManager.game_manager = self
    # ---
    current_gui   = gui_container.get_child(0)
    current_scene = main_scene_container.get_child(0)
    # ---
    main_scene_container.remove_child(current_scene)
    scene_still_loaded.append(current_scene)
    # ---  --- #
    ui_node_dic[GlobalSettings.UI_KEYS.MAIN_MENU  ] = Utilities.find_first_child_of_type(gui_container, GameMenu) as GameMenu
    ui_node_dic[GlobalSettings.UI_KEYS.NEW_MISSION] = Utilities.find_first_child_of_type(gui_container, NewMissionMenu) as NewMissionMenu
    EventBus.ChangeMainUIRequested.connect(change_gui_scene)
    #start_splash_screens("res://scenes/start_spalsh_screens/splash_screens.tscn")

# ====== MANAGEMENT ====== #

func change_main_scene(new_scene:PackedScene)->void:
    if is_instance_valid(new_scene):
        current_scene.queue_free()
        var new_main_scene = check_if_scene_already_loaded(new_scene)
        if not(is_instance_valid(new_main_scene)):
            new_main_scene = new_scene.instantiate()
        # ---
        main_scene_container.add_child(new_main_scene)
        current_scene      = new_main_scene

func change_gui_scene(new_ui_key:GlobalSettings.UI_KEYS)->void:
    var new_ui = ui_node_dic[new_ui_key]
    if not(is_instance_valid(new_ui)):
        push_error("new ui invalid")
        return
    # ---
    scene_transition_overlay.transition(SceneTransitionOverlay.TRANS_TYPE.FADE_OUT)
    await scene_transition_overlay.animation_player.animation_finished
    current_gui.visible = false
    new_ui.visible      = true
    scene_transition_overlay.transition(SceneTransitionOverlay.TRANS_TYPE.FADE_IN)
    await scene_transition_overlay.animation_player.animation_finished
    current_gui = new_ui
    return

func check_if_scene_already_loaded(scene:PackedScene)->Node:
    for i in range(scene_still_loaded.size()):
        var item = scene_still_loaded[i] as Node
        if item.scene_file_path==scene.resource_path:
            return scene_still_loaded.pop_at(i)
    return null
