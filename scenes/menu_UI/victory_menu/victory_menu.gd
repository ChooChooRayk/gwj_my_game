class_name VictoryMenu
extends Control


# ====== INITIALIZATION ====== #

func _ready() -> void:
    var current_level :Level = Utilities.find_first_parent_of_type(self, Level) as Level
    if is_instance_valid(current_level):
        PlayerStatistics.current_money += current_level.mission_res.money_reward # to change and add animation/ui element for visualisation

# ====== MANAGEMENT ====== #

func return_to_main_menu()->void:
    EventBus.ChangeMainUIRequested.emit(GlobalSettings.UI_KEYS.MAIN_MENU)

func quit_game()->void:
    get_tree().quit()
    
func next_mission()->void:
    EventBus.PauseMainSceneRequested.emit(true)
    EventBus.ChangeMainUIRequested.emit(GlobalSettings.UI_KEYS.NEW_MISSION)
    
