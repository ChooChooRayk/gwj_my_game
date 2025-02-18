class_name NewMissionMenu
extends Control

@export var next_mission : GlobalSettings.SCENE_KEYS = GlobalSettings.SCENE_KEYS.TEST

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

func on_start_mission()->void:
    if is_instance_valid(inventory_ui.current_selected_item):
        PlayerStatistics.current_cleaning_tool = inventory_ui.current_selected_item.item_res
        EventBus.ChangeMainSceneRequested.emit(next_mission)
    else:
        popup_panel.visible = true
    return

func on_set_visible()->void:
    if visible and is_instance_valid(mission_call_display):
        await get_tree().create_timer(mission_call_display.auto_start_delay).timeout
        mission_call_display.start_conversation()
