class_name InventoryToolStack
extends Button

signal double_ckicked()

@export var tool : TemperingTool
@export var tool_nbr : int = 1:
    set(value):
        tool_nbr = value
        update_stack_nbr()

var inventory_hud : InventoryHUD

# ====== INITIALIZATION ====== #

func _ready() -> void:
    inventory_hud = Utilities.find_first_parent_of_type(self, InventoryHUD) as InventoryHUD
    #if not(is_instance_valid(inventory_hud)):
        #push_error("tool stack should child of InventoryHUD")
    # ---
    if is_instance_valid(tool):
        icon = tool.icon
    # ---
    update_stack_nbr()

# ====== PROCESS ====== #

func _gui_input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.double_click:
        tool_selected()
        double_ckicked.emit()
        
# ====== MANAGEMENT ====== #

func update_stack_nbr()->void:
    if tool_nbr==0:
        queue_free()
    # ---
    text = "{nbr}".format({"nbr":tool_nbr})

func tool_selected()->void:
    inventory_hud.on_tool_selected(tool)
    return
