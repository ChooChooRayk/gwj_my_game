class_name PauseMenu
extends Control

@onready var continue_bttn  : Button = %Continue
@onready var main_menu_bttn : Button = %MainMenu
@onready var quit_bttn      : Button = %Quit


# ====== INITIALIZATION ====== #

func _ready() -> void:
    visible      = false
    process_mode = PROCESS_MODE_WHEN_PAUSED
    return

# ====== MANAGEMENT ====== #

func return_to_main_menu()->void:
    get_tree().paused = false
    EventBus.ChangeMainUIRequested.emit(GlobalSettings.UI_KEYS.MAIN_MENU)

func quit_game()->void:
    get_tree().quit()
    
func continue_game()->void:
    visible = false
    get_tree().paused = false
