extends Node

signal MoneyUpdated(delta_money:float)
signal CurrentToolUpdated()

@export var mission_manager : MissionManager = load("res://resources/missions/player_default_mission_manager.tres") as MissionManager

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
@export var current_money : int = 1250: # [$USD]
    set(value):
        var delta_money = value - current_money
        current_money   = value
        MoneyUpdated.emit(delta_money)

var crime_item_tempering_time : float = 10. # [s]

# ====== INITIALIZATION ====== #

func _ready() -> void:
    current_cleaning_tool = default_tools["cleaning"]
    current_framing_tool  = default_tools["framing" ]
    # ---
    EventBus.AddItemToInventory     .connect(add_new_item_to_inventory )
    EventBus.RemoveItemFromInventory.connect(remove_item_from_inventory)

# ====== MANAGEMENT ====== #

func get_mission()->MissionResource:
    var mission_key := mission_manager.get_current_mission()
    return GlobalSettings.missions_dic[mission_key]

func set_next_level()->void:
    mission_manager.set_next_mission()
    
# ------ INVENTORY MANAGEMENT ------ #

func add_new_item_to_inventory(item:TemperingTool)->void:
    if inventory.has(item):
        inventory[item] += 1
    else:
        inventory[item] = 1
    # ---
    EventBus.InventoryUpdated.emit()

func remove_item_from_inventory(item:TemperingTool)->void:
    if not(inventory.has(item)):
        push_warning("item not in inventory")
        return
    # ---
    inventory[item] -= 1
    if inventory[item]==0:
        inventory.erase(item)
    # ---
    if item.type == TemperingTool.TYPE.CLEANING:
        if item == current_cleaning_tool:
            current_cleaning_tool = default_tools["cleaning"]
    if item.type == TemperingTool.TYPE.FRAMING:
        if item == current_framing_tool:
            current_framing_tool = default_tools["framing"]
    # ---
    EventBus.InventoryUpdated.emit()

func tool_selected(item:TemperingTool)->void:
    if not(inventory.has(item)):
        push_error("something wrong with the implementation of tool selection")
    match item.type:
        TemperingTool.TYPE.CLEANING:
            current_cleaning_tool = item
        TemperingTool.TYPE.FRAMING:
            current_framing_tool = item
        TemperingTool.TYPE.HIDING:
            EventBus.PlayerHidingRequested.emit()
            remove_item_from_inventory(item)
        _:
            push_error("type of Tempering tool not recognized")
    return

# ------------ #

func reset_stats()->void:
    mission_manager.reset_missions()
    return
