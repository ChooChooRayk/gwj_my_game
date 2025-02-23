class_name OnPressedMenuMusic
extends Node

var parent_ctrl : Button

func _ready() -> void:
    parent_ctrl = get_parent() as Button
    # ---
    if is_instance_valid(parent_ctrl):
        parent_ctrl.pressed.connect(play_menu_music)
    
func play_menu_music()->void:
    var game_manager := Utilities.find_first_child_of_type(get_tree().root, Game) as Game
    var menu_music  :AudioStream = (game_manager.ui_node_dic[GlobalSettings.UI_KEYS.MAIN_MENU] as GameMenu).menu_music
    MusicManager.play_audio(menu_music, true)
