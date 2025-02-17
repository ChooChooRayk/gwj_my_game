class_name HUD
extends Control

var current_level : Level
var player_stats  : PlayerStatistics

@onready var mission_timer: Label = %MissionTimer

# ====== INITIALIZATION ====== #

func _ready() -> void:
    current_level = Utilities.find_first_parent_of_type(self, Level) as Level
    
# ====== PROCESS ====== #

func _physics_process(delta: float) -> void:
    update_timer_display()

# ====== MANAGEMENT ====== #

func update_timer_display()->void:
    var time_left      = roundf(current_level.mission_timer.time_left)
    mission_timer.text = "Time left : {time}".format({"time":time_left})
    return
