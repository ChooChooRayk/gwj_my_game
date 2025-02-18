extends Node

func return_to_main_menu()->void:
    EventBus.ChangeMainUIRequested.emit(GlobalSettings.UI_KEYS.MAIN_MENU)

func quit_game()->void:
    get_tree().quit()
    
