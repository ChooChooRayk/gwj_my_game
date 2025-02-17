class_name NewMissionMenu
extends Control


@onready var main_menu_bttn    : Button = %MainMenuBttn
@onready var start_mission_bttn: Button = %StartMissionBttn

# ====== INITIALIZATION ====== #

func _ready() -> void:
    return


# ====== MANAGEMENT ====== #

func on_return_to_main_menu()->void:
    EventBus.ChangeMainUIRequested.emit(GlobalSettings.UI_KEYS.MAIN_MENU)
    return

func on_start_mission()->void:
    EventBus.ChangeMainSceneRequested.emit(GlobalSettings.SCENE_KEYS.LEVEL_1)
    return
