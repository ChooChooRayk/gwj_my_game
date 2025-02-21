class_name SettingsMenu
extends PanelContainer


@onready var main_menu_bttn : Button = %MainMenuBttn
@onready var reset_bttn     : Button = %ResetBttn
@onready var apply_bttn     : Button = %ApplyBttn

@onready var input_remap: InputRemappingSettings = %InputRemap

@onready var master_volume  : HSlider      = %MasterVolume
@onready var sfx_volume     : HSlider      = %SFXVolume
@onready var windowing      : OptionButton = %Windowing
@onready var tuto_enable    : CheckBox     = %TutoEnable
@onready var windowing_size : OptionButton = %WindowingSize

# ====== INITIALIZATION ====== #

func _ready() -> void:
    init_default_settings()
    return

func init_default_settings()->void:
    GlobalSettings.default_game_settings["master_vol"] = master_volume.value
    GlobalSettings.default_game_settings["sfx_vol"   ] = sfx_volume.value
    GlobalSettings.default_game_settings["windowing" ] = windowing.selected
    GlobalSettings.default_game_settings["tutorial"  ] = tuto_enable.button_pressed
    return

# ====== MANAGEMENT ====== #

func set_custom_settings()->void:
    GlobalSettings.current_game_settings["master_vol"] = master_volume.value
    GlobalSettings.current_game_settings["sfx_vol"   ] = sfx_volume.value
    GlobalSettings.current_game_settings["windowing" ] = windowing.selected
    GlobalSettings.current_game_settings["tutorial"  ] = tuto_enable.button_pressed
    return


func on_reset_settings()->void:
    input_remap.reset_settings()
    # ---
    master_volume.value          = GlobalSettings.default_game_settings["master_vol"]
    sfx_volume   .value          = GlobalSettings.default_game_settings["sfx_vol"   ]
    windowing    .selected       = GlobalSettings.default_game_settings["windowing" ]
    tuto_enable  .button_pressed = GlobalSettings.default_game_settings["tutorial"  ]
    # ---
    on_apply_settings()
    return

func on_apply_settings()->void:
    set_custom_settings()
    # --- windowing
    match GlobalSettings.current_game_settings["windowing" ]:
        0:
            get_tree().root.mode = Window.MODE_FULLSCREEN
        1:
            get_tree().root.mode = Window.MODE_WINDOWED
        _:
            get_tree().root.mode = Window.MODE_FULLSCREEN
    # --- volume : to do ...
    return
    
func return_to_main_menu()->void:
    return
    
    
