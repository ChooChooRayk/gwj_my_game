class_name ShopItemUI
extends Button

signal double_ckicked()

var item_res : TemperingTool
var shop_ui  : ShopUI

# ====== INITIALIZATION ====== #

func _ready() -> void:
    if is_instance_valid(item_res):
        icon = item_res.icon
        text = "cost : {price}$".format({"price":item_res.price})
    # ---
    shop_ui = Utilities.find_first_parent_of_type(self, ShopUI) as ShopUI
    return

# ====== PROCESS ====== #

func _gui_input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.double_click:
        auto_buy_item()
        double_ckicked.emit()
        
# ====== MANAGEMENT ====== #

func auto_buy_item()->void:
    if is_instance_valid(shop_ui):
        shop_ui.on_buying()
    return
