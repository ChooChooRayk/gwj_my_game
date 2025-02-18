class_name InventoryUI
extends PanelContainer


@onready var item_container: GridContainer = %ItemContainer

var invtry_item_scene :PackedScene = load("res://scenes/menu_UI/inventory/inventory_item_ui.tscn")
var button_grp : ButtonGroup = ButtonGroup.new()

var current_selected_item : InventoryItemUI

# ====== INITIALIZATION ====== #

func _ready() -> void:
    EventBus.NewItemInInventoryAdded.connect(update_shop_ui)
    # ---
    init_inventory()
    return

func init_inventory()->void:
    clear_item_container()
    update_shop_ui()
    return

# ====== MANAGEMENT ====== #

func clear_item_container()->void:
    for child in item_container.get_children():
        child.queue_free()
    return

func update_shop_ui()->void:
    for i in range(PlayerStatistics.inventory.size()):
        var item_res = PlayerStatistics.inventory[i]
        var invtry_item : InventoryItemUI = invtry_item_scene.instantiate()
        invtry_item.item_res = item_res
        invtry_item.button_group = button_grp
        invtry_item.pressed.connect(update_selected_item)
        # ---
        item_container.add_child(invtry_item)
    return
    
func get_selected_item()->InventoryItemUI:
    var selected_item :InventoryItemUI = button_grp.get_pressed_button()
    return selected_item

func update_selected_item()->void:
    var selected_item := get_selected_item()
    if not(is_instance_valid(selected_item)):
        current_selected_item = null
        return
    # ---
    current_selected_item = selected_item
