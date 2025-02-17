class_name HandCleaningDoneState
extends HandState





# ====== PROCESS ====== #

func process_input(event: InputEvent) -> void:
    if event.is_pressed():
        var forensic := raycast_check_for_forensic_scientist() as BodyMotor
        if is_instance_valid(forensic):
            if cleaning_hand.cleaning_tool.cleanable_zone.is_point_in_zone(forensic.foot_position.global_position):
                hide_crime_evidence_in_forensic(forensic)
        get_tree().root.set_input_as_handled()


# ====== MANAGEMENT ====== #

func enter()->void:
    #Input.set_custom_mouse_cursor(cleaning_done_aspect)
    EventBus.FrozePlayerRequested.emit(false)
    return
    
func exit()->void:
    return

func update_state()->void:
    return

func raycast_check_for_forensic_scientist()->CharacterBody2D:
    var space_state := cleaning_hand.get_world_2d().direct_space_state
    var query       := PhysicsPointQueryParameters2D.new()
    query.position   = cleaning_hand.get_global_mouse_position()
    query.collide_with_bodies = true
    query.collide_with_areas  = false
    query.collision_mask = GlobalSettings.LAYER_NAMES.BODIES
    # ---
    var result :Array[Dictionary] = space_state.intersect_point(query)
    if (result.size()!=0):
        for i in result.size():
            var body :CharacterBody2D = result[i].collider
            if body.is_in_group("forensic_scientists"):
                return body
    # ---
    return null

func hide_crime_evidence_in_forensic(_forensic)->void:
    print("crime evidence HIDDEN !!!!!!!!!")
    ChangeStateRequested.emit(self, STATES.OutZone)
    return
