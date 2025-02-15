class_name InspectorAI
extends Node

var npc_body : BodyMotor
var detection_zone : Area2D

# ====== INITIALIZATION ====== #

func _ready() -> void:
    npc_body       = get_parent() as BodyMotor
    detection_zone = Utilities.find_first_child_of_type(npc_body, Area2D)
    return

# ====== MANAGEMENT ====== #

func manage_detection_zone()->void:
    return
    
func on_player_deteted(body:Node2D)->void:
    if body.is_in_group("player"):
        pass
