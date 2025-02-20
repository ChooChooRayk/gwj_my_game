extends Node

signal MoneyUpdated()
signal CurrentToolUpdated()

var current_level_idx : int = 0
var level_list : Array[GlobalSettings.SCENE_KEYS] = [
    GlobalSettings.SCENE_KEYS.LEVEL_1,
]

var default_tools := {
    "cleaning": load("res://resources/cleaning_tools/default_cleaning_tool.tres") as TemperingTool,
    "framing" : load("res://resources/framing_tool/default_framing_tool.tres") as TemperingTool,
}

var current_framing_tool  : TemperingTool:
    set(value):
        current_framing_tool = value
        CurrentToolUpdated.emit()
var current_cleaning_tool : TemperingTool:
    set(value):
        current_cleaning_tool = value
        CurrentToolUpdated.emit()
var inventory             : Dictionary #  {key=TemperingTool : val=nbr      Array[TemperingTool]
var current_money         : int = 850: # [$USD]
    set(value):
        current_money = value
        MoneyUpdated.emit()

var crime_item_tempering_time : float = 10. # [s]

# ====== INITIALIZATION ====== #

func _ready() -> void:
    current_cleaning_tool = default_tools["cleaning"]
    current_framing_tool  = default_tools["framing" ]
    # ---
    EventBus.AddItemToInventory     .connect(add_new_item_to_inventory )
    EventBus.RemoveItemFromInventory.connect(remove_item_from_inventory)

# ====== MANAGEMENT ====== #

func get_level()->GlobalSettings.SCENE_KEYS:
    if current_level_idx==-1:
        return GlobalSettings.SCENE_KEYS.LEVEL_FINAL
    return level_list[current_level_idx]

func set_next_level()->void:
    current_level_idx += 1
    if current_level_idx>=level_list.size():
        current_level_idx = -1
    
# ------ INVENTORY MANAGEMENT ------ #

func add_new_item_to_inventory(item:TemperingTool)->void:
    if inventory.has(item):
        inventory[item] += 1
    else:
        inventory[item] = 1
    # ---
    EventBus.InventoryUpdated.emit()

func remove_item_from_inventory(item:TemperingTool)->void:
    print("remove item : ", item)
    print("current cleaning tool : ", current_cleaning_tool)
    print("current framing  tool : ", current_framing_tool)
    if not(inventory.has(item)):
        push_warning("item not in inventory")
        return
    # ---
    inventory[item] -= 1
    if inventory[item]==0:
        inventory.erase(item)
    # ---
    if item.type == TemperingTool.TYPE.CLEANING:
        print("is current item : ", item == current_cleaning_tool)
        if item == current_cleaning_tool:
            current_cleaning_tool = default_tools["cleaning"]
    if item.type == TemperingTool.TYPE.FRAMING:
        print("is current item : ", item == current_framing_tool)
        if item == current_framing_tool:
            current_framing_tool = default_tools["framing"]
    # ---
    EventBus.InventoryUpdated.emit()

func tool_selected(item:TemperingTool)->void:
    print("tool selected in PlayerStat : ", inventory)
    print("current cleaning tool : ", current_cleaning_tool)
    print("current framing  tool : ", current_framing_tool)
    if not(inventory.has(item)):
        push_error("something wrong with the implementation of tool selection")
    match item.type:
        TemperingTool.TYPE.CLEANING:
            current_cleaning_tool = item
        TemperingTool.TYPE.FRAMING:
            current_framing_tool = item
        _:
            push_error("type of Tempering tool not recognized")
    return

# ------------ #

func reset_stats()->void:
    current_level_idx = 0
    return
