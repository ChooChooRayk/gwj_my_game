class_name PauseMenu
extends Control

@onready var continue_bttn  : Button = %Continue
@onready var main_menu_bttn : Button = %MainMenu
@onready var quit_bttn      : Button = %Quit
@onready var settings       : Button = %Settings

@onready var pause_buttons  : PanelContainer = %PauseButtons
@onready var settings_menu  : SettingsMenu   = %SettingsMenu

# ====== INITIALIZATION ====== #

func _ready() -> void:
    visible      = false
    process_mode = PROCESS_MODE_WHEN_PAUSED
    # ---
    settings_menu.main_menu_bttn.pressed.connect(return_to_menu)
    settings_menu.main_menu_bttn.text = "Back"
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

func on_settings()->void:
    pause_buttons.visible = false
    settings_menu.visible = !pause_buttons.visible
    return

func return_to_menu()->void:
    pause_buttons.visible = true
    settings_menu.visible = !pause_buttons.visible
    return
