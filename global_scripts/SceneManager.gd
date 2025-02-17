extends Node

signal ChangeSceneRequested(path_to_scene:String)
signal NextSceneLoaded()

var game_manager : Game
var tween : Tween

var next_scene_path : String
var load_scene_progress : Array = []

func on_change_scene_requested(path_to_scene:String)->void:
    next_scene_path = path_to_scene
    # ---
    start_change_scene()
    await NextSceneLoaded
    end_change_scene()
    # ---
    return

# ====== PROCESS ====== #

func _process(delta: float) -> void:
    ResourceLoader.load_threaded_get_status(next_scene_path, load_scene_progress)
    if load_scene_progress[0]==1.0:
        NextSceneLoaded.emit()
    return
    
# ====== MANAGEMENT ====== #

func wait_for_scene_to_load()->void:
    set_process(true)
    await NextSceneLoaded
    set_process(false)
    return

func start_change_scene()->void:
    game_manager.scene_transition_overlay.transition(SceneTransitionOverlay.TRANSITION_TYPE.FADE_IN)
    ResourceLoader.load_threaded_request(next_scene_path)
    wait_for_scene_to_load()
    return

func end_change_scene()->void:
    var next_scene : PackedScene = ResourceLoader.load_threaded_get(next_scene_path)
    game_manager.change_main_scene(next_scene)
    game_manager.scene_transition_overlay.transition(SceneTransitionOverlay.TRANSITION_TYPE.FADE_OUT)
    return
