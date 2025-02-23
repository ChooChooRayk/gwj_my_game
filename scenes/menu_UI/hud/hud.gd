class_name HUD
extends Control

var current_level : Level
var player_stats  : PlayerStatistics

@onready var mission_timer : Label        = %MissionTimer
@onready var inventory_hud : InventoryHUD = %InventoryHUD
@onready var nbr_item      : Label        = %NbrItem
@onready var conv_displayer: ConversationDisplayer = %ConversationDisplayer

# ====== INITIALIZATION ====== #

func _ready() -> void:
    current_level = Utilities.find_first_parent_of_type(self, Level) as Level
    if is_instance_valid(current_level):
        current_level.LevelUpdated.connect(update_mission_status)

func init_hud()->void:
    update_timer_display()
    update_mission_status()
    update_inventory_hud()
    return

# ====== PROCESS ====== #

func _physics_process(_delta: float) -> void:
    update_timer_display()

# ====== MANAGEMENT ====== #

func update_timer_display()->void:
    if not(is_instance_valid(current_level)):
        return
    var time_left      = roundf(current_level.mission_timer.time_left)
    mission_timer.text = "Time left : {time}".format({"time":time_left})
    return
    
func update_mission_status()->void:
    nbr_item.text = "{nbr}".format({"nbr":current_level.item_left_to_hide})
    return

func update_inventory_hud()->void:
    inventory_hud.update_inventory_hud()
    return
