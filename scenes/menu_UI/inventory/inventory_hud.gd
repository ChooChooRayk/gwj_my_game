class_name InventoryHUD
extends PanelContainer


@onready var item_container: Container = %ToolsContainer

var invtry_item_scene : PackedScene = load("res://scenes/menu_UI/inventory/inventory_item_ui.tscn")
var invtry_tool_stack : PackedScene = load("res://scenes/menu_UI/inventory/inventory_tool_stack.tscn")

var button_grp := ButtonGroup.new()

@onready var cleaning_tool_display: TextureRect = %CurrentCleaningTool
@onready var framing_tool_display : TextureRect = %CurrentFramingTool

var inventory_hud_tools := {}

# ====== INITIALIZATION ====== #

func _ready() -> void:
    clear_item_container()
    update_inventory_hud()
    # ---
    EventBus.InventoryUpdated.connect(update_inventory_hud)
    return

#func init_inventory()->void:
    #update_inventory_hud()
    #return

# ====== MANAGEMENT ====== #

func clear_item_container()->void:
    for child in item_container.get_children():
        child.queue_free()
    return

func update_inventory_hud()->void:
    update_current_tools()
    update_tool_stacks()

func update_tool_stacks()->void:# may need in-game if implementation of finding Tempering tool in level
    for item:TemperingTool in PlayerStatistics.inventory.keys():
        if inventory_hud_tools.has(item):
            var tool_stack := inventory_hud_tools[item] as InventoryToolStack
            tool_stack.tool_nbr = PlayerStatistics.inventory[item]
        else:
            var tool_stack : InventoryToolStack = invtry_tool_stack.instantiate()
            tool_stack.tool         = item
            tool_stack.button_group = button_grp
            # ---
            item_container.add_child(tool_stack)
            inventory_hud_tools[item] = tool_stack
    # ---
    for item:TemperingTool in inventory_hud_tools.keys():
        if not(PlayerStatistics.inventory.has(item)):
            (inventory_hud_tools[item] as InventoryToolStack).queue_free()
            inventory_hud_tools.erase(item)
    return

func update_current_tools()->void:
    if is_instance_valid(PlayerStatistics.current_cleaning_tool):
        cleaning_tool_display.texture = PlayerStatistics.current_cleaning_tool.icon
    if is_instance_valid(PlayerStatistics.current_framing_tool):
        framing_tool_display .texture = PlayerStatistics.current_framing_tool.icon

func on_tool_selected(tool)->void:
    PlayerStatistics.tool_selected(tool)
    update_inventory_hud()
    return
