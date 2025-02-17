extends Control



func return_to_main_menu()->void:
    EventBus.ChangeMainUIRequested.emit(GlobalSettings.UI_KEYS.MAIN_MENU)

func quit_game()->void:
    get_tree().quit()
    
func next_mission()->void:
    EventBus.PauseMainSceneRequested.emit(true)
    EventBus.ChangeMainUIRequested.emit(GlobalSettings.UI_KEYS.NEW_MISSION)
    
