extends CanvasLayer


@onready var settings_menu: PanelContainer = $Control/SettingsMenu
@onready var main_menu: PanelContainer = $Control/MainMenu

@onready var start_button: Button = %StartButton
@onready var settings: Button = %Settings
@onready var quit: Button = %Quit
@onready var credits: Button = %Credits

# ====== INITIALIZATION ====== #

func _ready() -> void:
    settings_menu.main_menu_bttn.pressed.connect(return_to_main_menu)
    settings.pressed.connect(got_to_settings)
    quit.pressed.connect(get_tree().quit)
    return
    
# ====== MANAGEMENT ====== #

func return_to_main_menu()->void:
    settings_menu.visible = false
    main_menu.visible     = true

func got_to_settings()->void:
    settings_menu.visible = true
    main_menu.visible     = false
