class_name VictoryMenu
extends Control



@onready var inventory_ui  : InventoryUI           = %InventoryUI
@onready var conv_displayer: ConversationDisplayer = %ConversationDisplayer
var current_level:Level 

var init_wait_time := 1.

# ====== INITIALIZATION ====== #

func _ready() -> void:
    current_level = Utilities.find_first_parent_of_type(self, Level) as Level
    #visibility_changed.connect(init_menu)
    init_menu()

func init_menu()->void:
    await get_tree().create_timer(init_wait_time).timeout
    if is_instance_valid(current_level):
        inventory_ui.new_money = current_level.mission_res.money_reward
        PlayerStatistics.current_money += current_level.mission_res.money_reward # to change and add animation/ui element for visualisation
    # ---
    start_end_level_conv()
    return

# ====== MANAGEMENT ====== #

func return_to_main_menu()->void:
    EventBus.ChangeMainUIRequested.emit(GlobalSettings.UI_KEYS.MAIN_MENU)

func quit_game()->void:
    get_tree().quit()
    
func next_mission()->void:
    EventBus.PauseMainSceneRequested.emit(true)
    EventBus.ChangeMainUIRequested.emit(GlobalSettings.UI_KEYS.NEW_MISSION)

func start_end_level_conv()->void:
    if not(is_instance_valid(current_level)):
        return
    # ---
    conv_displayer.enable_auto_continue(true)
    conv_displayer.conversation_key = current_level.mission_res.mission_call_success
    conv_displayer.init_conversation()
    conv_displayer.start_conversation()
    return
