class_name HandInZoneState
extends HandState



# ====== PROCESS ====== #

func _process(_delta: float) -> void:
    update_state()

func process_input(event: InputEvent) -> void:
    if event.is_pressed():
        var evidence_item := raycast_check_for_evidence_item()
        if is_instance_valid(evidence_item):
            start_cleaning(evidence_item)
            
# ====== MANAGEMENT ====== #

func enter()->void:
    #Input.set_custom_mouse_cursor(cleaning_hand.cleaning_aspect)
    set_process(true)
    return

func exit()->void:
    set_process(false)
    return

func update_state()->void:
    if not cleaning_hand.cleaning_tool.clickable_zone.is_point_in_zone(cleaning_hand.get_global_mouse_position()):
        ChangeStateRequested.emit(self, STATES.OutZone)
    # ---
    return

func raycast_check_for_evidence_item()->Area2D:
    var space_state := cleaning_hand.get_world_2d().direct_space_state
    var query       := PhysicsPointQueryParameters2D.new()
    query.position   = cleaning_hand.get_global_mouse_position()
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

func start_cleaning(crime_item:CrimeEvidenceItem)->void:
    cleaning_hand.item_to_clean = crime_item
    ChangeStateRequested.emit(self, STATES.InCleaning)
    return
