class_name ShopItemUI
extends Button

var item_res : CleaningTool

# ====== INITIALIZATION ====== #

func _ready() -> void:
    if is_instance_valid(item_res):
        icon = item_res.icon
        text = "cost : {price}$".format({"price":item_res.price})
    return

# ====== MANAGEMENT ====== #
