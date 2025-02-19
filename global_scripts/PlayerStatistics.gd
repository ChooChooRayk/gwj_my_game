extends Node

signal MoneyUpdated()

var current_level_idx : int = 0
var level_list : Array[GlobalSettings.SCENE_KEYS] = [
    GlobalSettings.SCENE_KEYS.LEVEL_1,
]

var current_framing_tool  : TemperingTool = load("res://resources/framing_tool/default_framing_tool.tres") as TemperingTool
var current_cleaning_tool : CleaningTool  = load("res://resources/cleaning_tools/cleaning_cloth_base.tres") as CleaningTool
var inventory             : Array[CleaningTool]
var current_money         : int = 250: # [$USD]
    set(value):
        current_money = value
        MoneyUpdated.emit()

var crime_item_tempering_time : float = 10. # [s]

# ====== INITIALIZATION ====== #

func _ready() -> void:
    EventBus.AddItemToInventory.connect(add_new_item_to_inventory)

# ====== MANAGEMENT ====== #

func get_level()->GlobalSettings.SCENE_KEYS:
    if current_level_idx==-1:
        return GlobalSettings.SCENE_KEYS.LEVEL_FINAL
    return level_list[current_level_idx]

func set_next_level()->void:
    current_level_idx += 1
    if current_level_idx>=level_list.size():
        current_level_idx = -1
    

func add_new_item_to_inventory(item:CleaningTool)->void:
    if inventory.has(item):
        push_warning("item already in inventory")
        return
    # ---
    inventory.append(item)
    EventBus.NewItemInInventoryAdded.emit()

func remove_item_to_inventory(item:CleaningTool)->void:
    if not(inventory.has(item)):
        push_warning("item not in inventory")
        return
    # ---
    inventory.remove_at(inventory.find(item))
    EventBus.ItemInInventoryRemoved.emit()

# ------------ #

func reset_stats()->void:
    current_level_idx = 0
    return
