class_name InventoryHUD
extends PanelContainer


@onready var item_container: GridContainer = %ItemContainer

var invtry_item_scene :PackedScene = load("res://scenes/menu_UI/inventory/inventory_item_ui.tscn")

# ====== INITIALIZATION ====== #

func _ready() -> void:
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
    var item_res = PlayerStatistics.current_cleaning_tool
    var invtry_item : InventoryItemUI = invtry_item_scene.instantiate()
    invtry_item.item_res = item_res
    invtry_item.flat     = true
    # ---
    item_container.add_child(invtry_item)
    return
