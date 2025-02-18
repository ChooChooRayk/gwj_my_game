class_name NewMissionMenu
extends Control

@export var next_mission : GlobalSettings.SCENE_KEYS = GlobalSettings.SCENE_KEYS.TEST

@onready var main_menu_bttn    : Button = %MainMenuBttn
@onready var start_mission_bttn: Button = %StartMissionBttn

@onready var mission_call_display: ConversationDisplayer = %MissionCallDisplay

# ====== INITIALIZATION ====== #

func _ready() -> void:
    visibility_changed.connect(on_set_visible)
    return


# ====== MANAGEMENT ====== #

func on_return_to_main_menu()->void:
    EventBus.ChangeMainUIRequested.emit(GlobalSettings.UI_KEYS.MAIN_MENU)
    return

func on_start_mission()->void:
    EventBus.ChangeMainSceneRequested.emit(next_mission)
    return

func on_set_visible()->void:
    if visible and is_instance_valid(mission_call_display):
        await get_tree().create_timer(mission_call_display.auto_start_delay).timeout
        mission_call_display.start_conversation()
