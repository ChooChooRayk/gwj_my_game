class_name SettingsMenu
extends PanelContainer


@onready var main_menu_bttn : Button = %MainMenuBttn
@onready var reset_bttn     : Button = %ResetBttn
@onready var apply_bttn     : Button = %ApplyBttn

@onready var input_remap: InputRemappingSettings = %InputRemap

@onready var master_volume  : HSlider      = %MasterVolume
@onready var music_volume   : HSlider      = %MusicVolume
@onready var sfx_volume     : HSlider      = %SFXVolume
@onready var windowing      : OptionButton = %Windowing
@onready var tuto_enable    : CheckBox     = %TutoEnable
@onready var windowing_size : OptionButton = %WindowingSize

# ====== INITIALIZATION ====== #

func _ready() -> void:
    init_default_settings()
    # ---
    master_volume.value_changed.connect(func (_value): set_volume_settings())
    music_volume .value_changed.connect(func (_value): set_volume_settings())
    sfx_volume   .value_changed.connect(func (_value): set_volume_settings())
    return

func init_default_settings()->void:
    GlobalSettings.default_game_settings["master_vol"] = master_volume.value
    GlobalSettings.default_game_settings["music_vol" ] = music_volume.value
    GlobalSettings.default_game_settings["sfx_vol"   ] = sfx_volume.value
    GlobalSettings.default_game_settings["windowing" ] = windowing.selected
    GlobalSettings.default_game_settings["tutorial"  ] = tuto_enable.button_pressed
    return

# ====== MANAGEMENT ====== #

func set_custom_settings()->void:
    #GlobalSettings.current_game_settings["master_vol"] = master_volume.value
    #GlobalSettings.current_game_settings["music_vol" ] = music_volume.value
    #GlobalSettings.current_game_settings["sfx_vol"   ] = sfx_volume.value
    set_volume_settings()
    GlobalSettings.current_game_settings["windowing" ] = windowing.selected
    GlobalSettings.current_game_settings["tutorial"  ] = tuto_enable.button_pressed
    return

func set_volume_settings()->void:
    GlobalSettings.current_game_settings["master_vol"] = master_volume.value
    GlobalSettings.current_game_settings["music_vol" ] = music_volume.value
    GlobalSettings.current_game_settings["sfx_vol"   ] = sfx_volume.value
    # ---
    apply_volume_settings()

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
    apply_volume_settings()
    return

func apply_volume_settings()->void:
    var min_vol_db := 10.
    # --- Master
    var master_vol_mult :float=GlobalSettings.current_game_settings["master_vol"] / 100.
    var master_vol_db  := -min_vol_db*(1-master_vol_mult)
    master_vol_db = -80.0 if GlobalSettings.current_game_settings["master_vol"]==0 else master_vol_db
    AudioServer.set_bus_volume_db(int(AudioManager.BUS_TYPE.MASTER), master_vol_db)
    # --- Music
    var music_vol_db  :float= -min_vol_db*(1 - GlobalSettings.current_game_settings["music_vol"]/ 100.)
    music_vol_db = -80.0 if GlobalSettings.current_game_settings["music_vol"]==0 else music_vol_db
    MusicManager.bus_volume_db = music_vol_db
    # --- SFX
    var sfx_vol_db  :float= -min_vol_db*(1 - GlobalSettings.current_game_settings["sfx_vol"]/ 100.)
    sfx_vol_db = -80.0 if GlobalSettings.current_game_settings["sfx_vol"]==0 else sfx_vol_db
    SFXManager.bus_volume_db = sfx_vol_db
    # ---  --- #
    return



func return_to_main_menu()->void:
    return
    
    
