class_name InputPlayer
extends Node

var player_body:BodyMotor
var is_player_frozen := false

# ====== INITIALIZATION =====+ #

func _ready() -> void:
    player_body = get_parent() as BodyMotor
    # ---
    EventBus.FrozePlayerRequested.connect(set_player_frozen)

# ====== PROCESS ===== #

func _process(_delta: float) -> void:
    if not is_player_frozen:
        player_body.movement_direction = Input.get_vector("left","right","up","down")
    else:
        player_body.movement_direction = Vector2.ZERO
    # ---  --- #
    return

# ====== MANAGEMENT ===== #

func raycast_check_for_evidence_item()->Area2D:
    var space_state := player_body.get_world_2d().direct_space_state
    var query       := PhysicsPointQueryParameters2D.new()
    query.position   = player_body.get_global_mouse_position()
    query.collide_with_areas = true
    query.collision_mask = GlobalSettings.LAYER_NAMES.EVIDENCE_ITEM
    # ---
    var result :Array[Dictionary] = space_state.intersect_point(query)
    if (result.size()!=0):
        for i in result.size():
            var area :Area2D = result[i].collider
            if area.is_in_group("evidence_items"):
                return area
    # ---
    return null

func do_stuff()->void:
    return

func set_player_frozen(is_frozen:bool)->void:
    is_player_frozen = is_frozen
