class_name GameMenu
extends Control


@export var menu_music : AudioStream

@onready var settings_menu : SettingsMenu   = $SettingsMenu
@onready var main_menu     : PanelContainer = $MainMenu
@onready var credits       : PanelContainer = $Credits

@onready var start_button  : Button = %StartButton
@onready var settings      : Button = %Settings
@onready var quit          : Button = %Quit
@onready var credits_buttn : Button = %Credits

# ====== INITIALIZATION ====== #

func _ready() -> void:
    settings_menu.main_menu_bttn.pressed.connect(return_to_main_menu)
    quit.pressed.connect(get_tree().quit)
    # ---
    if is_instance_valid(menu_music):
        MusicManager.play_audio(menu_music, true)
    return
    
# ====== MANAGEMENT ====== #

func return_to_main_menu()->void:
    settings_menu.visible = false
    credits.visible       = false
    # ---
    main_menu.visible     = true

func go_to_settings()->void:
    settings_menu.visible = true
    main_menu.visible     = false

func go_to_credits()->void:
    credits.visible       = true
    main_menu.visible     = false

func on_start()->void:
    EventBus.ChangeMainUIRequested.emit(GlobalSettings.UI_KEYS.NEW_MISSION)
    return
    
