class_name InventoryUI
extends PanelContainer


@onready var item_container : GridContainer = %ItemContainer
@onready var player_money   : Label         = %PlayerMoney

#var invtry_item_scene :PackedScene = load("res://scenes/menu_UI/inventory/inventory_item_ui.tscn")
var invtry_item_scene :PackedScene = load("res://scenes/menu_UI/inventory/inventory_tool_stack.tscn")
var button_grp : ButtonGroup = ButtonGroup.new()

var current_selected_item : TemperingTool
var inventory_ui_tools := {}

var pause_mode_popup = Tween.TweenPauseMode.TWEEN_PAUSE_BOUND
var pop_money_scn : PackedScene = load("res://scenes/menu_UI/inventory/pop_up_money.tscn")
var new_money     : float = 0.0
# ====== INITIALIZATION ====== #

func _ready() -> void:
    EventBus        .InventoryUpdated.connect(update_inventory_ui)
    PlayerStatistics.MoneyUpdated    .connect(update_player_money_display)
    # ---
    init_inventory()
    return

func init_inventory()->void:
    clear_item_container()
    update_inventory_ui()
    return

# ====== MANAGEMENT ====== #

func clear_item_container()->void:
    for child in item_container.get_children():
        child.queue_free()
    return

func update_inventory_ui()->void:
    for item_res:TemperingTool in PlayerStatistics.inventory.keys():
        if inventory_ui_tools.has(item_res):
            var tool_stack = inventory_ui_tools[item_res] as InventoryToolStack
            tool_stack.tool_nbr = PlayerStatistics.inventory[item_res]
            tool_stack.update_stack_nbr()
        else:
            var invtry_item_stack : InventoryToolStack = invtry_item_scene.instantiate()
            invtry_item_stack.tool         = item_res
            invtry_item_stack.button_group = button_grp
            #invtry_item_stack.disabled     = true
            invtry_item_stack.mouse_filter = Control.MOUSE_FILTER_IGNORE
            # ---
            item_container.add_child(invtry_item_stack)
            inventory_ui_tools[item_res] = invtry_item_stack
    # ---
    for item:TemperingTool in inventory_ui_tools.keys():
        if not(PlayerStatistics.inventory.has(item)):
            (inventory_ui_tools[item] as InventoryToolStack).queue_free()
            inventory_ui_tools.erase(item)
    # ---
    update_player_money_display()
    return
    
func get_selected_item()->TemperingTool:
    var selected_item :InventoryItemUI = button_grp.get_pressed_button()
    if is_instance_valid(selected_item):
        return selected_item.item_res
    return null

func update_selected_item()->void:
    var selected_item := get_selected_item()
    if not(is_instance_valid(selected_item)):
        current_selected_item = null
        return
    # ---
    current_selected_item = selected_item

func update_player_money_display()->void:
    var pop_money : PopUpMoney = pop_money_scn.instantiate()
    pop_money.delta_money = new_money
    pop_money.pause_mode  = pause_mode_popup
    player_money.add_child(pop_money)
    pop_money.play_animation()
    # ---
    player_money.text = "money : {money}$".format({"money":PlayerStatistics.current_money})
