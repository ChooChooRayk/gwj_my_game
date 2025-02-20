class_name NewMissionMenu
extends Control

@export var next_mission : MissionResource

@onready var main_menu_bttn    : Button = %MainMenuBttn
@onready var start_mission_bttn: Button = %StartMissionBttn

@onready var mission_call_display : ConversationDisplayer = %MissionCallDisplay
@onready var shop_ui              : ShopUI                = %ShopUI
@onready var inventory_ui         : InventoryUI           = %InventoryUI
@onready var popup_panel          : PopupPanel            = %PopupPanel

# ====== INITIALIZATION ====== #

func _ready() -> void:
    visibility_changed.connect(on_set_visible)
    return


# ====== MANAGEMENT ====== #

func on_return_to_main_menu()->void:
    EventBus.ChangeMainUIRequested.emit(GlobalSettings.UI_KEYS.MAIN_MENU)
    return

func on_start_mission_pressed()->void:
    if inventory_ui.inventory_ui_tools.is_empty():
        popup_panel.visible = true
    else:
        start_mission()
    return

func start_mission()->void:
    popup_panel.visible = false
    EventBus.ChangeMainSceneRequested.emit(next_mission.mision_level)
    

func on_set_visible()->void:
    next_mission = PlayerStatistics.get_mission()
    # ---
    if visible and is_instance_valid(mission_call_display):
        mission_call_display.conversation_key = next_mission.mission_call_start
        mission_call_display.init_conversation()
        await get_tree().create_timer(mission_call_display.auto_start_delay).timeout
        mission_call_display.start_conversation()
    # ---
    PlayerStatistics.current_money += next_mission.money_start_mission
