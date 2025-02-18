extends Node


var current_level_idx : int = -1
var level_list : Array[GlobalSettings.SCENE_KEYS] = [
    GlobalSettings.SCENE_KEYS.LEVEL_1,
]

var current_cleaning_tool : CleaningTool = load("res://resources/cleaning_tools/all_items/cleaning_cloth_base.tres") as CleaningTool
var inventory             : Array[CleaningTool]
var current_money         : int = 250 # [$USD]

var crime_item_tempering_time : float = 10. # [s]

# ====== INITIALIZATION ====== #

func _ready() -> void:
    EventBus.AddItemToInventory.connect(add_new_item_to_inventory)

# ====== MANAGEMENT ====== #

func get_next_level()->GlobalSettings.SCENE_KEYS:
    current_level_idx += 1
    if current_level_idx>=level_list.size():
        return GlobalSettings.SCENE_KEYS.LEVEL_FINAL
    return level_list[current_level_idx]

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
    current_level_idx = -1
    return
