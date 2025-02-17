class_name Game
extends Node


@onready var scene_transition_overlay: SceneTransitionOverlay = $SceneTransitionOverlay


@export var gui_container        : CanvasLayer
@export var main_scene_container : Node2D
var current_gui   : Control
var current_scene : Node

var scene_still_loaded : Array = []

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

func change_gui_scene()->void:
    return

func check_if_scene_already_loaded(scene:PackedScene)->Node:
    for i in range(scene_still_loaded.size()):
        var item = scene_still_loaded[i] as Node
        if item.scene_file_path==scene.resource_path:
            return scene_still_loaded.pop_at(i)
    return null

func start_splash_screens()->void:
    var splash_screens := Utilities.find_first_child_of_type(gui_container, SplashScreens) as SplashScreens
    return
