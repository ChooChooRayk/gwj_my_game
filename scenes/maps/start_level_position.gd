class_name StartLevelPosition
extends Marker2D


# ====== INITIALIZATION ====== #

func _ready() -> void:
    var level := Utilities.find_first_parent_of_type(self, Level) as Level
    if not(is_instance_valid(level)):
        push_warning("no parent level found stop start position")
        return
    # ---
    var player_L := get_tree().get_nodes_in_group("player")
    if player_L.size()==0:
        push_warning("problem in finding a player un the current level")
        return
    var player := player_L[0] as BodyMotor
    player.global_position = global_position
