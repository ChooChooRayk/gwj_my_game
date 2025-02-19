class_name InventoryItemUI
extends Button

var item_res : TemperingTool

# ====== INITIALIZATION ====== #

func _ready() -> void:
    if is_instance_valid(item_res):
        icon = item_res.icon
    return
