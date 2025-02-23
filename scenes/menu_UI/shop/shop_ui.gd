class_name ShopUI
extends PanelContainer


@export var storage : Array[TemperingTool]

var shop_item_scene :PackedScene = load("res://scenes/menu_UI/shop/shop_item_ui.tscn")
var button_grp : ButtonGroup = ButtonGroup.new()

@onready var shop_itemp_container : GridContainer = %ShopItempContainer
@onready var shop_item_description: RichTextLabel = %ShopItemDescription

# ====== INITIALIZATION ====== #

func _ready() -> void:
    init_shop()
    return

func init_shop()->void:
    clear_item_container()
    for i in range(storage.size()):
        var item_res = storage[i]
        var shop_item : ShopItemUI = shop_item_scene.instantiate()
        shop_item.item_res = item_res
        shop_item.focus_entered.connect(func (): set_item_description(shop_item))
        shop_item.button_group = button_grp
        # ---
        shop_itemp_container.add_child(shop_item)
    return

# ====== MANAGEMENT ====== #

func clear_item_container()->void:
    for child in shop_itemp_container.get_children():
        child.queue_free()
    return

func set_item_description(item:ShopItemUI)->void:
    shop_item_description.text = item.item_res.description_txt
    return

func update_shop_ui()->void:
    return
    
func get_selected_item()->ShopItemUI:
    var selected_item :ShopItemUI = button_grp.get_pressed_button()
    return selected_item

func on_buying()->void:
    var selected_item :ShopItemUI = get_selected_item()
    if not(is_instance_valid(selected_item)):
        print("no item selected")
        return
    if PlayerStatistics.current_money>=selected_item.item_res.price:
        EventBus.AddItemToInventory.emit(selected_item.item_res)
        # ---
        PlayerStatistics.current_money -= selected_item.item_res.price
        #selected_item.queue_free()
    else:
        print("Not enough money !")
    # ---
    return
