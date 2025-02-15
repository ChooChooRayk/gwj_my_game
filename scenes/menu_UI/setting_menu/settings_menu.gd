extends PanelContainer


@onready var main_menu_bttn: Button = %MainMenuBttn
@onready var reset_bttn    : Button = %ResetBttn
@onready var apply_bttn    : Button = %ApplyBttn

@onready var input_remap: InputRemappingSettings = %InputRemap

@onready var master_volume: HSlider = %MasterVolume
@onready var sfx_volume: HSlider = %SFXVolume
@onready var windowing: OptionButton = %Windowing

var default_val_dic  := {}
var setting_wdgt_dic := {}


# ====== INITIALIZATION ====== #

func _ready() -> void:
    setting_wdgt_dic = {
        "master_vol":master_volume,
        "sfx_vol":sfx_volume,
        "windowing":windowing,
    }
    init_default_settings()
    return

func init_default_settings()->void:
    default_val_dic = {
        "master_vol":master_volume.value,
        "sfx_vol":sfx_volume.value,
        "windowing":windowing.selected,
    }
    return

# ====== MANAGEMENT ====== #

func on_reset_settings()->void:
    input_remap.reset_settings()
    # ---
    setting_wdgt_dic["windowing" ].selected = default_val_dic["windowing" ]
    setting_wdgt_dic["master_vol"].value    = default_val_dic["master_vol"]
    setting_wdgt_dic["sfx_vol"   ].value    = default_val_dic["sfx_vol"   ]
    # ---
    on_apply_settings()
    return

func on_apply_settings()->void:
    # --- windowing
    match setting_wdgt_dic["windowing" ].selected:
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
    
    
