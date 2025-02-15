class_name InputPlayer
extends Node

var player_body:BodyMotor

# ====== INITIALIZATION =====+ #

func _ready() -> void:
    player_body = get_parent() as BodyMotor

# ====== PROCESS ===== #

func _process(_delta: float) -> void:
    player_body.movement_direction = Input.get_vector("left","right","up","down")

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT:
        if event.is_pressed():
            var evidence_item := raycast_check_for_evidence_item()
            if is_instance_valid(evidence_item):
                EventBus.EvidenceCleaningStarted.emit(evidence_item)
        elif event.is_released():
            EventBus.EvidenceCleaningStopped.emit()
            

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
